Return-Path: <SRS0=Jcgg=JK=lists.cip-project.org=bounce+64572+6363+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA6EC43461
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649FE613AE
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649FE613AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6363+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FYp8YY4521723xf7cGnquRqr; Tue, 13 Apr 2021 01:55:25 -0700
X-Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web08.6314.1618304124468915606
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Apr 2021 01:55:24 -0700
X-Received: by mail-pf1-f170.google.com with SMTP id y16so11010698pfc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Apr 2021 01:55:24 -0700 (PDT)
X-Gm-Message-State: 7m47rA2H4XgLqAnnJiMAMrIDx4520388AA=
X-Google-Smtp-Source: ABdhPJwyW8ZGEA4yhxmwIxT/IeSwfK6BUD5XvdMjqjYfxJE0rzIrNUacgPzSsCYD2qw7UqQHQPlMUg==
X-Received: by 2002:a63:79c6:: with SMTP id u189mr30692263pgc.154.1618304123828;
        Tue, 13 Apr 2021 01:55:23 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l17sm13318807pgi.66.2021.04.13.01.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 01:55:23 -0700 (PDT)
Message-ID: <60755c7b.1c69fb81.a12ef.0f07@mx.google.com>
Date: Tue, 13 Apr 2021 01:55:23 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.186-cip47
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.19.y-cip igt-kms-rockchip: 2 runs, 1 regressions (v4.19.186-cip47) #kernelci
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
Content-Type: multipart/mixed; boundary="286sO2JGPYU561Yu2DhW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618304125;
 bh=67P6T7BI1QVqVsfeT44q9lWTPO2h+pYwXDCUvErlZeE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ar9B0aSOXUq2+EAvbdENVcTnnCjG4nWQYP2H2Uzi/sbxZdXkHzzmgG/6+KLQQQjDD8a
 lO37mkXotOVOOpEPwltrk38CGuWSAsKcRKCNuZJPfv2NDyKoTGmSe2vrtlcRxaK+ja6ND
 /Je+q0JEu3HGQygf6HWhLJEMXjPxEzx917g=

--286sO2JGPYU561Yu2DhW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip igt-kms-rockchip: 2 runs, 1 regressions (v4.19.186-cip=
47)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.186-cip47/plan/igt-kms-rockchip/

  Test:     igt-kms-rockchip
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.186-cip47
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6aacc392bf723d573084332054aa3070424576fe

  Test suite revisions:
    drm
      URL:  git://anongit.freedesktop.org/mesa/drm
      SHA:  991e95fd138e6b651e4c549772a08bc21a054ff6
    igt-gpu-tools
      URL:  https://gitlab.freedesktop.org/drm/igt-gpu-tools.git
      SHA:  d3b7f74ce5df6fdea03e490b7c64f0c6bfe76f03 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/60754c846253304f3adac71f

  Results:     85 PASS, 3 FAIL, 146 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.186=
-cip47/arm64/defconfig/gcc-8/lab-collabora/igt-kms-rockchip-rk3399-gru-kevi=
n.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.186=
-cip47/arm64/defconfig/gcc-8/lab-collabora/igt-kms-rockchip-rk3399-gru-kevi=
n.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster-igt/=
20210412.0/arm64/rootfs.cpio.gz =



  * igt-kms-rockchip.kms_vblank.pipe-B-ts-continuation-suspend: https://ker=
nelci.org/test/case/id/60754c856253304f3adac7a9
        new failure (last pass: v4.19.183-cip46)

    2021-04-13 07:46:47.718000+00:00  <6>[  159.145223] Console: switching =
to colour dummy device 80x25
    2021-04-13 07:46:47.723000+00:00  <14>[  159.151790] [IGT] kms_vblank: =
executing
    2021-04-13 07:46:47.737000+00:00  IGT-Version: 1.25-gd3b7f74 (aarch64) =
(Linux: 4.19.186-cip47 aarc<14>[  159.157213] [IGT] kms_vblank: starting su=
btest pipe-B-ts-continuation-suspend
    2021-04-13 07:46:47.738000+00:00  h64)
    2021-04-13 07:46:47.742000+00:00  Starting subtest: pipe-B-ts-continuat=
ion-suspend
    2021-04-13 07:46:48.487000+00:00  <6>[  159.912654] rockchip-dp ff97000=
0.edp: Link Training Clock Recovery success
    2021-04-13 07:46:48.501000+00:00  <6>[  159.927903] rockchip-dp ff97000=
0.edp: Link Training success!
    2021-04-13 07:46:48.643000+00:00  Beginning pipe-B-ts-continuation-susp=
end on pipe B, connector eDP-1
    2021-04-13 07:46:48.660000+00:00  [cmd] rtcwake: assuming RTC uses UTC =
...
    2021-04-13 07:46:48.667000+00:00  rtcwake: wakeup from \"mem\" using /d=
ev/rtc0 at Tue Apr 13 07:45:32 2021 =

    ... (124 line(s) more)  =

 =20

--286sO2JGPYU561Yu2DhW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6363): https://lists.cip-project.org/g/cip-dev/message=
/6363
Mute This Topic: https://lists.cip-project.org/mt/82060342/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--286sO2JGPYU561Yu2DhW--

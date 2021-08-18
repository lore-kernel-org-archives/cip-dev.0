Return-Path: <SRS0=Ogw6=NJ=lists.cip-project.org=bounce+64572+6691+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827FEC4338F
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 17:22:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBA1610CF
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 17:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BBA1610CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HBVkYY4521723xonTwBuPptQ; Wed, 18 Aug 2021 10:22:14 -0700
X-Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web08.57888.1629307334307596620
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Aug 2021 10:22:14 -0700
X-Received: by mail-pf1-f176.google.com with SMTP id m26so2827277pff.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Aug 2021 10:22:14 -0700 (PDT)
X-Gm-Message-State: 4vBPCVIvkTPrk31AdBoxWNRBx4520388AA=
X-Google-Smtp-Source: ABdhPJw8eo8UOm+fNbvcyLo/fDw0Z4Kl16A3ggC9U3sYRv8/p+WtPNMR0ofEHqaMo2+jsm4v2Yo1dA==
X-Received: by 2002:a05:6a00:23cf:b0:3e2:4622:da6d with SMTP id g15-20020a056a0023cf00b003e24622da6dmr10335615pfc.18.1629307333726;
        Wed, 18 Aug 2021 10:22:13 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d17sm354099pfn.110.2021.08.18.10.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:22:13 -0700 (PDT)
Message-ID: <611d41c5.1c69fb81.c27c0.15fa@mx.google.com>
Date: Wed, 18 Aug 2021 10:22:13 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.204-cip55
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip sleep: 6 runs, 1 regressions (v4.19.204-cip55) #kernelci
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
Content-Type: multipart/mixed; boundary="g6jlOHyOLbIvJXz6uqHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629307334;
 bh=Pxc/rJAJHtKIE7j73O4Z2VAnCPF5wImIbMRh0C6jyII=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=EMOOmPGeGDRKbZ/jLbWQJLqamCpDZND8y6S58Pf+kP0ErR7XW7eqE96mvYJXmO2hSxM
 gQXtJBYVCDrrTmB/iMAAtLx5k6y5iNPXbb0+y3mx2Za4hEGzQvgio6AzMaaaZJ34TgVa2
 SuqLSHNMyTyxisPp2tvh15tcfFjWaoWwKGw=

--g6jlOHyOLbIvJXz6uqHV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip sleep: 6 runs, 1 regressions (v4.19.204-cip55)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.204-cip55/plan/sleep/

  Test:     sleep
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.204-cip55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      62089879a4547be35f0c23d8992c51ab5898e076 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/611d30336e62eb7898b1367d

  Results:     12 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.204=
-cip55/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/arm64/rootfs.cpio.gz =



  * sleep.rtcwake-mem-9: https://kernelci.org/test/case/id/611d30336e62eb78=
98b13680
        new failure (last pass: v4.19.196-cip53)

    2021-08-18T16:02:57.508679  rtcwake: assuming RTC uses UTC ...
    2021-08-18T16:02:57.514286  rtcwake: wakeup from \"mem\" using rtc0 at =
Wed Aug 18 16:01:42 2021
    2021-08-18T16:02:57.526691  <6>[   41.289634] PM: suspend entry (deep)
    2021-08-18T16:02:57.533625  <6>[   41.295802] PM: Syncing filesystems .=
.. done.
    2021-08-18T16:02:57.544560  <6>[   41.303062] Freezing user space proce=
sses ... (elapsed 0.001 seconds) done.
    2021-08-18T16:02:57.550872  <6>[   41.314291] OOM killer disabled.
    2021-08-18T16:02:57.562818  <6>[   41.320061] Freezing remaining freeza=
ble tasks ... (elapsed 0.001 seconds) done.
    2021-08-18T16:02:57.570706  <6>[   41.331660] Suspending console(s) (us=
e no_console_suspend to debug)
    2021-08-18T16:02:58.694728  <3>[   41.935659] mwifiex_pcie 0000:01:00.0=
: adapter is not valid
    2021-08-18T16:02:58.703393  <4>[   42.000138] xhci-hcd xhci-hcd.2.auto:=
 WARN: xHC CMD_RUN timeout =

    ... (13 line(s) more)  =

 =20

--g6jlOHyOLbIvJXz6uqHV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6691): https://lists.cip-project.org/g/cip-dev/message/=
6691
Mute This Topic: https://lists.cip-project.org/mt/84977537/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--g6jlOHyOLbIvJXz6uqHV--

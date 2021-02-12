Return-Path: <SRS0=OsBT=HO=lists.cip-project.org=bounce+64572+6175+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A77C433DB
	for <cip-dev@archiver.kernel.org>; Fri, 12 Feb 2021 17:10:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B78364E02
	for <cip-dev@archiver.kernel.org>; Fri, 12 Feb 2021 17:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B78364E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6175+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id k4wkYY4521723xP5tmNUtj8d; Fri, 12 Feb 2021 09:10:19 -0800
X-Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web08.6860.1613149818760661185
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Feb 2021 09:10:18 -0800
X-Received: by mail-pf1-f173.google.com with SMTP id 189so6183713pfy.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 12 Feb 2021 09:10:18 -0800 (PST)
X-Gm-Message-State: XOyip8TbclQfVRgKaFQQvQnfx4520388AA=
X-Google-Smtp-Source: ABdhPJxmzRJX45ytBEK3AiG9KQoFn3oS4EuzLRKJBhyuwe2rirjZfXogRuOtU/DX/UfQVlHTrkdR0A==
X-Received: by 2002:a63:f447:: with SMTP id p7mr3972482pgk.243.1613149817889;
        Fri, 12 Feb 2021 09:10:17 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s11sm9054535pfu.69.2021.02.12.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 09:10:17 -0800 (PST)
Message-ID: <6026b679.1c69fb81.51da6.3fad@mx.google.com>
Date: Fri, 12 Feb 2021 09:10:17 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.257-cip54
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
Subject: [cip-dev] cip/linux-4.4.y-cip usb: 3 runs, 2 regressions (v4.4.257-cip54) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="GALtYdnV9eGectng82d7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613149819;
 bh=autXTgmAHEh/5nIhBdh5Hd5kVX1I65yClWhD6Npqe8k=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NeMKCdVL1Dp+ZFSszs/qgWSjzXMl9bPPnhh5oZRMJn6WNPvESQuM6LcdcV+zt1FU5Hm
 0dH2Ume3xoonczmVF6f5wHAJAd1b29w+HyiImEpo79ZhxFW5czRELejt0aFaYCspa9by0
 vd5mfHVMwkh6Aa8bb5o3emTeT9EMu5Ld834=

--GALtYdnV9eGectng82d7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip usb: 3 runs, 2 regressions (v4.4.257-cip54)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.257-cip54/plan/usb/

  Test:     usb
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.257-cip54
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7d472e4a11d6a2fb1c492b02c7d7dacd3297bbf4 =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/6026af9c67c6f6fb993abe82

  Results:     2 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.257-c=
ip54/arm/multi_v7_defconfig/gcc-8/lab-collabora/usb-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.257-c=
ip54/arm/multi_v7_defconfig/gcc-8/lab-collabora/usb-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0208.0/armhf/rootfs.cpio.gz =



  * usb.compare-freeze: https://kernelci.org/test/case/id/6026af9c67c6f6fb9=
93abe85
        new failure (last pass: v4.4.249-cip53)

    2021-02-12 16:40:39.083000+00:00  002 \"
    2021-02-12 16:40:39.083000+00:00  + lsusb
    2021-02-12 16:40:39.083000+00:00  + awk {print $6}
    2021-02-12 16:40:39.084000+00:00  + sort
    2021-02-12 16:40:39.092000+00:00  + seq 1 3
    2021-02-12 16:40:39.104000+00:00  + /usr/sbin/rtcwake -d rtc0 -m freeze=
 -s 1
    2021-02-12 16:40:39.105000+00:00  rtcwake: assuming RTC uses UTC ...
    2021-02-12 16:40:39.110000+00:00  rtcwake: wakeup from \"freeze\" using=
 rtc0 at Fri Feb 12 16:40:42 2021
    2021-02-12 16:40:39.128000+00:00  [   18.897495] PM: Syncing filesystem=
s ... done.
    2021-02-12 16:40:39.142000+00:00  [   18.903115] Freezing user space pr=
ocesses ... (elapsed 0.001 seconds) done. =

    ... (71 line(s) more)  =


  * usb.compare-mem: https://kernelci.org/test/case/id/6026af9c67c6f6fb993a=
be86
        new failure (last pass: v4.4.249-cip53)

    2021-02-12 16:40:48.717000+00:00  @@ -1,[   28.484770] <LAVA_SIGNAL_TES=
TCASE TEST_CASE_ID=3Dcompare-freeze RESULT=3Dfail>
    2021-02-12 16:40:48.730000+00:00  4 +1,5 @@
    2021-02-12 16:40:48.730000+00:00   0424:9514
    2021-02-12 16:40:48.731000+00:00  +0424:ec00
    2021-02-12 16:40:48.731000+00:00   04f2:b443
    2021-02-12 16:40:48.731000+00:00   1d6b:0002
    2021-02-12 16:40:48.731000+00:00   1d6b:0002
    2021-02-12 16:40:48.732000+00:00  + seq 1 3
    2021-02-12 16:40:48.732000+00:00  + /usr/sbin/rtcwake -d rtc0 -m mem -s=
 1
    2021-02-12 16:40:48.736000+00:00  rtcwake: assuming RTC uses UTC ... =

    ... (89 line(s) more)  =

 =20

--GALtYdnV9eGectng82d7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6175): https://lists.cip-project.org/g/cip-dev/message=
/6175
Mute This Topic: https://lists.cip-project.org/mt/80588341/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GALtYdnV9eGectng82d7--

Return-Path: <SRS0=CEwL=PA=lists.cip-project.org=bounce+64572+6812+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61629C433F5
	for <cip-dev@archiver.kernel.org>; Tue, 12 Oct 2021 19:42:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E954D60D07
	for <cip-dev@archiver.kernel.org>; Tue, 12 Oct 2021 19:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E954D60D07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8DVcYY4521723xgEW6tuPbbx; Tue, 12 Oct 2021 12:42:31 -0700
X-Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web08.18912.1634067751136002472
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 12 Oct 2021 12:42:31 -0700
X-Received: by mail-pg1-f171.google.com with SMTP id d23so103117pgh.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 12 Oct 2021 12:42:31 -0700 (PDT)
X-Gm-Message-State: HRG4YVszvVsa7bCQf9AUw8wlx4520388AA=
X-Google-Smtp-Source: ABdhPJwb5im82QNeUza3gLfMxItIjpi0yDXegvUgQFyKPUdDx3xcELWP/DJOfWTJ2NWxbx3DEwY4Jg==
X-Received: by 2002:a05:6a00:198a:b0:44c:ae90:85fc with SMTP id d10-20020a056a00198a00b0044cae9085fcmr33573957pfl.1.1634067750277;
        Tue, 12 Oct 2021 12:42:30 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t6sm12027659pfh.63.2021.10.12.12.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 12:42:29 -0700 (PDT)
Message-ID: <6165e525.1c69fb81.ae6a8.21ba@mx.google.com>
Date: Tue, 12 Oct 2021 12:42:29 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.209-cip59
Subject: [cip-dev] cip/linux-4.19.y-cip sleep: 8 runs, 2 regressions (v4.19.209-cip59) #kernelci
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
Content-Type: multipart/mixed; boundary="qWEtDE07BBQAsPDcdQXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634067751;
 bh=uNSsm3Wa/5h9DkJyiY3//1hzm8qqE3TYU9KwUViutPk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ipHMlXHdaIYiTYP0pXk/IcEfnWWD0bHvouXbw4dRdPLZsWhd6oqy6TKBn/enolxPs9W
 vOTyin38l/Y9gfAQ7M8JcYD8mWBCITJXK9Gw97aVNVG7fThLgKkAFXDADJ3kb4CI3qbKU
 L3UXkMmD6t5DVaCFwIGJXDPUiF9DlDlj3tU=

--qWEtDE07BBQAsPDcdQXK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip sleep: 8 runs, 2 regressions (v4.19.209-cip59)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-8    | x86_64_defcon...6-=
chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.209-cip59/plan/sleep/

  Test:     sleep
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.209-cip59
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      11e803e05e061dc32e92deb7bd73c20dfbc48ae5 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-8    | x86_64_defcon...6-=
chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6165cbc2f8f0cd8e0a08fac0

  Results:     21 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/x86_64/x86_64_defconfig+x86-chromebook/gcc-8/lab-collabora/sleep-hp-=
11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/x86_64/x86_64_defconfig+x86-chromebook/gcc-8/lab-collabora/sleep-hp-=
11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
1008.0/amd64/rootfs.cpio.gz =



  * sleep.rtcwake-freeze-8: https://kernelci.org/test/case/id/6165cbc2f8f0c=
d8e0a08fac4
        new failure (last pass: v4.19.206-cip57)

    2021-10-12T17:53:35.328305  rtcwake: assuming RTC uses UTC ...
    2021-10-12T17:53:35.333729  rtcwake: wakeup from \"freeze\" using rtc0 =
at Tue Oct 12 17:53:41 2021
    2021-10-12T17:53:35.346487  <6>[   61.447864] Freezing user space proce=
sses ... (elapsed 0.001 seconds) done.
    2021-10-12T17:53:35.349601  <6>[   61.456127] OOM killer disabled.
    2021-10-12T17:53:35.360237  <6>[   61.459614] Freezing remaining freeza=
ble tasks ... (elapsed 0.003 seconds) done.
    2021-10-12T17:53:35.366813  <6>[   61.470306] Suspending console(s) (us=
e no_console_suspend to debug)
    2021-10-12T17:53:35.619989  =

    2021-10-12T17:53:35.620828  =

    2021-10-12T17:53:35.624849  coreboot-56f9d1cd49 Thu Sep  5 21:57:06 UTC=
 2019 smm starting...
    2021-10-12T17:53:35.625521   =

    ... (1147 line(s) more)  =


  * sleep.rtcwake-freeze-7: https://kernelci.org/test/case/id/6165cbc2f8f0c=
d8e0a08fac5
        new failure (last pass: v4.19.206-cip57)

    2021-10-12T17:53:35.296526  rtcwake: assuming RTC uses UTC ...
    2021-10-12T17:53:35.303034  rtcwake: wakeup from \"freeze\" using rtc0 =
at Tue Oct 12 17:53:41 2021
    2021-10-12T17:53:35.314017  <6>[   61.419378] PM: suspend entry (s2idle)
    2021-10-12T17:53:35.316924  <6>[   61.423401] PM: suspend exit
    2021-10-12T17:53:35.319258  rtcwake: write error   =

 =20

--qWEtDE07BBQAsPDcdQXK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6812): https://lists.cip-project.org/g/cip-dev/message/=
6812
Mute This Topic: https://lists.cip-project.org/mt/86271527/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qWEtDE07BBQAsPDcdQXK--

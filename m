Return-Path: <SRS0=4iyI=JK=lists.cip-project.org=bounce+64572+6371+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44E6C433B4
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 11:33:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616DF61244
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 11:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616DF61244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6371+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zAJqYY4521723xuUY38aEkhU; Tue, 13 Apr 2021 04:33:04 -0700
X-Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web08.7630.1618313584310336801
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Apr 2021 04:33:04 -0700
X-Received: by mail-pj1-f41.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so4005981pja.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Apr 2021 04:33:04 -0700 (PDT)
X-Gm-Message-State: k6GJjhnf8dWnbACdxjA5VM2bx4520388AA=
X-Google-Smtp-Source: ABdhPJzxrDg+WOA5dhi2ggu8JNTsOgSHdy80PzxMKZbW5eQaciKEPG0T37cWE97lyViHAScFRPbBGQ==
X-Received: by 2002:a17:90a:2e0d:: with SMTP id q13mr4478770pjd.225.1618313583656;
        Tue, 13 Apr 2021 04:33:03 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e14sm14559818pga.14.2021.04.13.04.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:33:03 -0700 (PDT)
Message-ID: <6075816f.1c69fb81.67cf4.330e@mx.google.com>
Date: Tue, 13 Apr 2021 04:33:03 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.266-cip56
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.4.y-cip usb: 5 runs, 2 regressions (v4.4.266-cip56) #kernelci
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
Content-Type: multipart/mixed; boundary="OyMlZY8RZqecTA8b7HuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618313584;
 bh=kpXslze3t9Kb+E7IAt2wSLoaSx9+UngRL9Th4N3PnUk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=mRTfyXqpDYLvcWOC6TZtB6Jdv7FJJst/nAjqMDYt7T7DjyQBzJNLD46CnXC+2lAVyWu
 D+cl0mqYZaNVC/7lWHTWQcOXuv92V8F45dk7MorGgLWiyrNI30lwXGDGJLbCbcqRw6Uzo
 XpBWYvuNrY/7ZvLIjrQII4rSvY4AMyMDGMI=

--OyMlZY8RZqecTA8b7HuP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip usb: 5 runs, 2 regressions (v4.4.266-cip56)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.266-cip56/plan/usb/

  Test:     usb
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.266-cip56
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cd5f211fda95e43a37ce2bf1d58486233641da9b =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/607571322ca80ca362dac6b4

  Results:     2 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-collabora/usb-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.266-c=
ip56/arm/multi_v7_defconfig/gcc-8/lab-collabora/usb-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0412.0/armhf/rootfs.cpio.gz =



  * usb.compare-freeze: https://kernelci.org/test/case/id/607571322ca80ca36=
2dac6b7
        new failure (last pass: v4.4.262-cip55)

    2021-04-13 10:23:24.981000+00:00  001: ID 1d6b:0002 \"
    2021-04-13 10:23:24.982000+00:00  + lsusb
    2021-04-13 10:23:24.982000+00:00  + awk {print $6}
    2021-04-13 10:23:24.982000+00:00  + sort
    2021-04-13 10:23:24.996000+00:00  + seq 1 3
    2021-04-13 10:23:24.997000+00:00  + /usr/sbin/rtcwake -d rtc0 -m freeze=
 -s 1
    2021-04-13 10:23:24.997000+00:00  rtcwake: assuming RTC uses UTC ...
    2021-04-13 10:23:25.001000+00:00  rtcwake: wakeup from \"freeze\" using=
 rtc0 at Tue Apr 13 10:23:27 2021
    2021-04-13 10:23:25.017000+00:00  [   18.874949] PM: Syncing filesystem=
s ... done.
    2021-04-13 10:23:25.032000+00:00  [   18.879888] Freezing user space pr=
ocesses ... (elapsed 0.001 seconds) done. =

    ... (71 line(s) more)  =


  * usb.compare-mem: https://kernelci.org/test/case/id/607571322ca80ca362da=
c6b8
        new failure (last pass: v4.4.262-cip55)

    2021-04-13 10:23:34.164000+00:00  @@ -1,[   28.019555] <LAVA_SIGNAL_TES=
TCASE TEST_CASE_ID=3Dcompare-freeze RESULT=3Dfail>
    2021-04-13 10:23:34.176000+00:00  4 +1,5 @@
    2021-04-13 10:23:34.176000+00:00   0424:9514
    2021-04-13 10:23:34.176000+00:00  +0424:ec00
    2021-04-13 10:23:34.177000+00:00   04f2:b443
    2021-04-13 10:23:34.177000+00:00   1d6b:0002
    2021-04-13 10:23:34.177000+00:00   1d6b:0002
    2021-04-13 10:23:34.177000+00:00  + seq 1 3
    2021-04-13 10:23:34.177000+00:00  + /usr/sbin/rtcwake -d rtc0 -m mem -s=
 1
    2021-04-13 10:23:34.184000+00:00  rtcwake: assuming RTC uses UTC ... =

    ... (89 line(s) more)  =

 =20

--OyMlZY8RZqecTA8b7HuP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6371): https://lists.cip-project.org/g/cip-dev/message=
/6371
Mute This Topic: https://lists.cip-project.org/mt/82062301/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OyMlZY8RZqecTA8b7HuP--

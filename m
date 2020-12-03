Return-Path: <SRS0=ZOg3=FH=lists.cip-project.org=bounce+64572+5941+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF0CC64E8A
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 11:14:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CFF22241
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 11:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CFF22241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5941+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id s3G2YY4521723xRSGTxW8z39; Thu, 03 Dec 2020 03:14:38 -0800
X-Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web12.6028.1606973560402939656
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Dec 2020 21:32:40 -0800
X-Received: by mail-pf1-f178.google.com with SMTP id q22so526937pfk.12
        for <cip-dev@lists.cip-project.org>; Wed, 02 Dec 2020 21:32:40 -0800 (PST)
X-Gm-Message-State: 0EUZfe2sEim0nYz9KlG5E5GTx4520388AA=
X-Google-Smtp-Source: ABdhPJyXAHcwC9Ug2zcdOE2UebPh/+qhvn1rEU/BBazFrCB1MTGApkfn62s3apqy31tuhTLh6YUv0g==
X-Received: by 2002:a65:6219:: with SMTP id d25mr1677216pgv.154.1606973559297;
        Wed, 02 Dec 2020 21:32:39 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k23sm236706pfk.50.2020.12.02.21.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 21:32:38 -0800 (PST)
Message-ID: <5fc87876.1c69fb81.a7e0a.0844@mx.google.com>
Date: Wed, 02 Dec 2020 21:32:38 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.243-cip51-21-g1d9a9094c010
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.4.y-cip usb: 4 runs, 2 regressions (v4.4.243-cip51-21-g1d9a9094c010)
To: cip-dev@lists.cip-project.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="Xi6LyCDYBJ6PB1BTUQyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606994078;
 bh=K46axdmakKbAa8rpSyrkjeRSC3L5LmYQOo2NftUKBvA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=rTpFACp5p9P8cjMD4FwSt4h92Gl1vVHKmjNwlMlrDgz6rAtrsN598pfCI3386zP9aBx
 kbHpEcm4t1SKCBlqTh/DjP9nAzGwAro5MmVdgLpTh7MSKMV8aLiN9oV6NjjpeneY7hf1t
 IlR7HKSSDH1dgELi+kr7UPWF3RQcMY9UMVg=

--Xi6LyCDYBJ6PB1BTUQyr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip usb: 4 runs, 2 regressions (v4.4.243-cip51-21-g1d9a9094=
c010)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.243-cip51-21-g1d9a9094c010/plan/usb/

  Test:     usb
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.243-cip51-21-g1d9a9094c010
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1d9a9094c01054b624cd936e8b130a2c27e38c49 =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/5fc871ebf573faf8a4c94cc7

  Results:     2 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-collabora/usb-rk3288=
-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.243-c=
ip51-21-g1d9a9094c010/arm/multi_v7_defconfig/gcc-8/lab-collabora/usb-rk3288=
-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1130.0/armhf/rootfs.cpio.gz =



  * usb.compare-freeze: https://kernelci.org/test/case/id/5fc871ebf573faf8a=
4c94cca
        new failure (last pass: v4.4.243-cip51-10-gd7466739b72e9)

    2020-12-03 05:04:20.932000+00:00  + /usr/sbin/rtcwake -d rtc0 -m freeze=
 -s 1
    2020-12-03 05:04:20.932000+00:00  rtcwake: assuming RTC uses UTC ...
    2020-12-03 05:04:20.937000+00:00  rtcwake: wakeup from \"freeze\" using=
 rtc0 at Thu Dec  3 05:04:23 2020
    2020-12-03 05:04:20.954000+00:00  [   18.787404] PM: Syncing filesystem=
s ... done.
    2020-12-03 05:04:20.967000+00:00  [   18.792542] Freezing user space pr=
ocesses ... (elapsed 0.001 seconds) done.
    2020-12-03 05:04:20.968000+00:00  [   18.800704] Freezing remaining fre=
ezable tasks ... (elapsed 0.001 seconds) done.
    2020-12-03 05:04:20.972000+00:00  [   18.809224] Suspending console(s) =
(use no_console_suspend to debug)
    2020-12-03 05:04:23.674000+00:00  [   18.865290] hub 3-1:1.0: activate =
--> -113
    2020-12-03 05:04:23.675000+00:00  [   18.867538] PM: suspend of devices=
 complete after 51.550 msecs
    2020-12-03 05:04:23.685000+00:00  [   18.868293] PM: late suspend of de=
vices complete after 0.750 msecs =

    ... (66 line(s) more)  =


  * usb.compare-mem: https://kernelci.org/test/case/id/5fc871ebf573faf8a4c9=
4ccb
        new failure (last pass: v4.4.243-cip51-10-gd7466739b72e9)

    2020-12-03 05:04:30.020000+00:00  02-14 10:12:11.459256544 +0000
    2020-12-03 05:04:30.032000+00:00  @@ -1,4 +1,5 @@
    2020-12-03 05:04:30.032000+00:00   0424:9514
    2020-12-03 05:04:30.032000+00:00  +0424:ec00
    2020-12-03 05:04:30.032000+00:00   04f2:b443
    2020-12-03 05:04:30.033000+00:00   1d6b:0002
    2020-12-03 05:04:30.033000+00:00   1d6b:0002
    2020-12-03 05:04:30.033000+00:00  + seq 1 3
    2020-12-03 05:04:30.033000+00:00  + /usr/sbin/rtcwake -d rtc0 -m mem -s=
 1
    2020-12-03 05:04:30.038000+00:00  rtcwake: assuming RTC uses UTC ... =

    ... (89 line(s) more)  =

 =20

--Xi6LyCDYBJ6PB1BTUQyr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5941): https://lists.cip-project.org/g/cip-dev/message=
/5941
Mute This Topic: https://lists.cip-project.org/mt/78682105/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Xi6LyCDYBJ6PB1BTUQyr--

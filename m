Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA03C433FE
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 09:23:49 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.9159.1667553827558939872
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 04 Nov 2022 02:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Kzaff3xR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id r18so3876283pgr.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 04 Nov 2022 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YfGVsGZnOOTQgF46eeA/jG+4oghQFl4KR40GJIIBuSI=;
        b=Kzaff3xRTuhDlStjwtEX4m31mZYyqrOVi6m+VKpGmgllLZ6kz+F+IB7CmhNIr8h9Mq
         UbpC2xSwL71gIFT2JryLdSvR9ji+KQodqaquMCZcgqbkYh5HcS+B/b17eZyqxws4pXSN
         DVH0ge9vRGhWEmK3ir7nEV5WDpqjhypMVncSOHyf8Byzc+n6nhiYMMtReQG0C4bB7xpC
         KVRVOwL1hLAWFPXF8+fgaRTMNh+jaMFolcbPjmxDcCSMYC83PiQ/cWw7apKhVa1n871s
         bHjr6aG0NMmpbcKL1l3s1rYw+MwJ0YoBYevVXu1FfUd19CItc/4SlFlAgUAncZqwe7Iy
         2KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfGVsGZnOOTQgF46eeA/jG+4oghQFl4KR40GJIIBuSI=;
        b=TPbfkUUBu92mn2FIMuYNR9Lt1L5aaRq7rNrVQzReChqkQtYGdBdiTWUIvpORhygN1X
         gTxpkuOrNSW75FUiPeYn/XeS+y2FbVtMkqOhXD9/5B4S8+/DOxNT6RhSEkNMRG43zTt1
         xYTig2jPnYA/1otJSgJzTQaDQx032wsXv7eaBPY7E8upp/kXKb4j1fPmwYIMboiskhT8
         L3ohsgz1eWdN+3SuqAoAgVuXntDypW9iSm+srnUrtCjSALeWwABUDhM4eNXq8ZDD4qBh
         G9j2UI45CHtV1jVlKnVXmxJIL0UAga7Cza41n8rOfpHJWt4i/zvDFzQxGBo3/oMcaZ/d
         Bz+Q==
X-Gm-Message-State: ACrzQf1o9hu9ky34bv54f3S4CAuHkeVqxAb3GOin6ui+jOEY6SfMBw4+
	EXp49smppSNMjQrD57GCMkggDIroQD2AyQ==
X-Google-Smtp-Source: AMsMyM4UjPjnGOKtoHWQfgR2Lwr6HHZ7S+gTOMlZCY1AdgVs0zDJoEN2i+sTiOnWhDC560E8fhWfHg==
X-Received: by 2002:a05:6a00:1ad2:b0:56d:ec92:9825 with SMTP id f18-20020a056a001ad200b0056dec929825mr15174245pfv.25.1667553826980;
        Fri, 04 Nov 2022 02:23:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a17090a1d0500b0020adf65cebbsm1294754pjd.8.2022.11.04.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:23:46 -0700 (PDT)
Message-ID: <6364da22.170a0220.f9d14.28a0@mx.google.com>
Date: Fri, 04 Nov 2022 02:23:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 3 runs,
 1 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 09:23:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9933

cip/linux-5.10.y-cip smc: 3 runs, 1 regressions (v5.10.147-cip18-12-gcb2b16=
4780be)

Regressions Summary
-------------------

platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.147-cip18-12-gcb2b164780be/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c =



Test Regressions
---------------- =



platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6364c4e1f3a6e1fd8ee7db62

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qe=
mu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qe=
mu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/6364c4e1f3a6e1fd8e=
e7db64
        failing since 79 days (last pass: v5.10.131-cip13-37-ge3a52725ce96,=
 first fail: v5.10.131-cip13-49-g1145e9c6352e6)

    2022-11-04T07:52:53.734617  <8>[    2.561299] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =20


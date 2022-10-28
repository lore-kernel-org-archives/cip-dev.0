Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4478C38A02
	for <webhook@archiver.kernel.org>; Fri, 28 Oct 2022 15:21:36 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.751.1666970490692631369
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 28 Oct 2022 08:21:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=k54BIFOz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id c2so5102222plz.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 28 Oct 2022 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YDzBN0d9e6mI9Y44uUipwWAZ4aF5PGK1SmNSkkTsTBw=;
        b=k54BIFOz+FuKahqftgKYBkuHQmSnv6fuXiANgpJmslEZAuQCgFdJqfM5nipbQvRC/S
         2wAcG84ZHTf01klHSr6uLvEp0JdwOyBXnLrSJwGPKvxSLoBDXHzUw8nODEGpmGTd+IWB
         f46FxzqnzO3LBsDErg4cKihGPja2g7T2VjsH75zww9f+umQKTVIO2Tj9ZrYb/8PQrPkx
         FO5bRs49jsfmTbr3A3/t2opPBpsrFaUH0V7y8a8WGjuaaNuUOLc/OhY3ch7DzChEd6lA
         f902k1cwxy74VAxBhU671oa1nDRUerG6Ms0hBx8ONBRq8jqIqbntTNYrHY/ybOJSrNmb
         f8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDzBN0d9e6mI9Y44uUipwWAZ4aF5PGK1SmNSkkTsTBw=;
        b=xhYEh9lKIn0a7kcCes0JOZFRZ2vZCT1XVwmto+RUn9/X8OohVjQQTsC+ouJjq0qRDD
         UzMNad8hAU8UEZpWBgowx2wAe9Xya0hh9WmTftcbj9aJVJQlunpJTB7xiLBgk3ushxdU
         Lqb/cydlu3zaRYYRUuFyAJwcNKZoUvEkFYgYriFmas+/zG6tidlJKBNOiV27IiIp97ce
         IOkYh1mDOPDiOx6hX/wcCRJwJWnnVt2mJyeBtaD4FhC0kk3EpFPlxdaT2G/yCe7bbPiQ
         H7zfjURNWGRuKpsuteFbww5CeU6Lvox0R7WMNegXTqhxHr6W/QSEE5qMEIhXkUKwMlHS
         vVfg==
X-Gm-Message-State: ACrzQf30Dvt137QYUEL+qHfZj4brxyVJrh9gl2v1C511TpFhvLR//Jy/
	Ikwa1dPjzBc9GmcCsEyJTFbfkkXRTrHJm7Xo
X-Google-Smtp-Source: AMsMyM77miP8vUUvcYQ+uVrd3uuxDH6J5VR9VUXvOxJ4KBXZtk894SImDjA59xmh18cMJMj6pNlY3g==
X-Received: by 2002:a17:90b:38c5:b0:20d:2938:8123 with SMTP id nn5-20020a17090b38c500b0020d29388123mr16607229pjb.59.1666970489917;
        Fri, 28 Oct 2022 08:21:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y123-20020a623281000000b0056bf24f0837sm2979140pfy.166.2022.10.28.08.21.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:21:29 -0700 (PDT)
Message-ID: <635bf379.620a0220.209fc.622e@mx.google.com>
Date: Fri, 28 Oct 2022 08:21:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-468-g86403a07ae1c
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs,
 2 regressions (v5.10.147-cip18-468-g86403a07ae1c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Oct 2022 15:21:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9889

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 2 regre=
ssions (v5.10.147-cip18-468-g86403a07ae1c)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-468-g86403a07ae1c/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-468-g86403a07ae1c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      86403a07ae1c0fdab3215fcaa06d157c20aee250 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/635be10dabddae77c4e7db59

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/635be10dabddae77c4e7db5f
        failing since 125 days (last pass: v5.10.118-465-g0af29783a3c9, fir=
st fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/635be100261b21f05be7dbbb

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/635be100261b21f05be7dbc1
        failing since 125 days (last pass: v5.10.118-465-g0af29783a3c9, fir=
st fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20


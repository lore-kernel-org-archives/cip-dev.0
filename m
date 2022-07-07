Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1053CC43334
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 07:07:43 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.2776.1657177661298516263
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Jul 2022 00:07:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=DuZNa+1u;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id n12so17647827pfq.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Jul 2022 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=b8fxlIPXG5/UexMF5yYylieRoEIMZ1vRxVAAIsMf7jg=;
        b=DuZNa+1uY6EKJwN1DDtiqxxoW4zjrO2zjTv73V7Rx2GKHnrdf0WWInEE1OuPLu8Ek0
         SHM574jMMFSBrck/tM1vJIUfNEiuDqsoX091pihBJ8d183PMdM9t5PviV+AF5WNJMlEo
         I3qkP+j9/tEO/67oQnElVcqhs3YvPus7ldyUZkztMnfL098KXKn/yeYr553+zz7kGec+
         HH6R64VlxJYXkf7clh5iSp6DSZO7cBXnqYIanQIcGjmbL8WhdUcf6Jhpgx1PxMGDNkGy
         kkc1X+1ZBXkPWH3kNb/pXBFCxuY3EtcBEi1Kcc3F318wKbKlV09ARi09UvMnP307X/Ju
         G9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=b8fxlIPXG5/UexMF5yYylieRoEIMZ1vRxVAAIsMf7jg=;
        b=lvyIFVFc/l/HSbwmFpPkeHRvgrWw7/wVbvRbvwoIWV+G4bmSIyKPz0JqBRA8H1JRLo
         RF80pMrq5+jq+1WGcqHd2Hn3xGLKgVCLJkKP1gXZLzyLCaS5MNZXiVa6kecr5mqIt+2/
         QHX/cuPGm9REjPV7v36p9SSefMaFLAY5HQak52Ig12RuV8zHx+Py1PoWzjCM8Sb6FmsV
         DfGq+GGQFnWy9wHyHNsY7WF8kL0W6w/L+EbTa2hHKWrINGP00rAhGSTbbd+YuhSZID6C
         Nghj/9W/y3uHIZSghBt1415Cl8yfwVCCM3fp1FyLUCn6jL6vtY80s1Dj5LZb42VH3VZa
         kMPQ==
X-Gm-Message-State: AJIora91sgig/+b7m6k0Pelrj+wwT+VNSPy9tUFngHrB/5ibnCnrHHwk
	CCVwHVBGOyJ+bCp5ejAXHm0L8FdEwARlZggq
X-Google-Smtp-Source: 
 AGRyM1t++9239h+s8zvzHm8BTzjBWUb5OAZdx3Ty3uTeNXfIgKhKqFHKJmOYlH/JjAhTZVpfCrMqSw==
X-Received: by 2002:a05:6a00:a0c:b0:528:5233:f119 with SMTP id
 p12-20020a056a000a0c00b005285233f119mr27250606pfh.69.1657177660623;
        Thu, 07 Jul 2022 00:07:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 h4-20020a170902680400b0016bf5557690sm4970064plk.4.2022.07.07.00.07.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:07:40 -0700 (PDT)
Message-ID: <62c6863c.1c69fb81.29533.7d19@mx.google.com>
Date: Thu, 07 Jul 2022 00:07:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-116-gef362fbbff528
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 2 regressions (v5.10.126-cip11-116-gef362fbbff528)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Jul 2022 07:07:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8711

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 2 regre=
ssions (v5.10.126-cip11-116-gef362fbbff528)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-116-gef362fbbff528/plan/kselfte=
st-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-116-gef362fbbff528
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef362fbbff528b6dc0695b488cfc8cde20b404e4 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c67340778474c121a39bd1

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ00=
05-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ00=
05-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c67340778474c121a39bd7
        failing since 12 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c67354c069a1ba68a39bfb

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-gru=
nt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-gru=
nt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c67354c069a1ba68a39c2b
        failing since 12 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20


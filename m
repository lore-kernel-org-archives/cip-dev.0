X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.3739.1647472422236037640
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 16:13:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=uZlv5RMw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id mz9-20020a17090b378900b001c657559290so3669007pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=appUCbENRC+HGPrBuOE0qMQTdv6I/Nl+FWmg67q/lu0=;
        b=uZlv5RMw53i0zJDAzTYrkYY+nz0NyjANxnwmQqV0uj7RvbYeorfyQRSdEzan6t89qA
         YyfbJ/qBZ28TooN7MK/evpI9S0yuPmeRznL3Cf3yJI+74r30/NommdF10A6svaMAAzua
         ecCSTj8Ve56fuCoBGha8ITkcpf4da6jGs4VgX64sQ7HNQj4Ju3KoUnWCATl5aLgJxBDE
         0K+ns4eGho/wfeX09WUuuvUjy97O706RznvM2M7eLSHWc805j/ET1yukNbjCvGz4JU5w
         Gl86Ayq+/5+R1KqnE48uWj5bxRyisg4Uxq+ApTmTdmVQoIr7Y4ZBVmtMrEC5YZ/eZxcE
         M9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=appUCbENRC+HGPrBuOE0qMQTdv6I/Nl+FWmg67q/lu0=;
        b=YBojoIUwAoLkKMxsOINZ8cB/C/Q1Fja6gVJ6WEN9II8E6FxRNwozs1cDDDE4Et0en8
         fbp8LCP8BAZQmQgT/fQQMIdeqjQfXRRP0eNu/vRqnrSuQx0EANDtqJ1mpxXSJhDOhWZE
         K53Shw0qO9Y2Dt8PstyEXX13pfTkroVSM8vnaWvJUrtrzX4jmnWU/tbvldP7lGBXHjaE
         Se57yvVmBEkV5p68qfxQFobfKPOI3qI34KDj1JQvCWo/NiK6R9S0JMLHmKQ+6HxTqSK9
         8wH504mpzkvmn2xaOE6QvM92tlpXIEcR7hM2CL/1DQUxpZB4PiqnyJfFPJRRJij5bNpV
         9YKA==
X-Gm-Message-State: AOAM530P/7XZbv06BLjInZ0Nn3TnArMyLacud8UgTDtJFW+HnNubIRcE
	OzAr56kgoiW3HALTXI0yXkjbjAjacY919Rv7nI0=
X-Google-Smtp-Source: ABdhPJyLg99c0KXFlKdtEyGIR3sL92rHqa5/VYnkmbqeUDCXrjzqcUDN05XLqdPuTO45pupIQw272g==
X-Received: by 2002:a17:903:110c:b0:14a:f110:84e1 with SMTP id n12-20020a170903110c00b0014af11084e1mr2148024plh.7.1647472421521;
        Wed, 16 Mar 2022 16:13:41 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id hg1-20020a17090b300100b001bf70e72794sm7535069pjb.40.2022.03.16.16.13.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:13:41 -0700 (PDT)
Message-ID: <62326f25.1c69fb81.e77b0.3c60@mx.google.com>
Date: Wed, 16 Mar 2022 16:13:41 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.104-cip3-132-g46c091c34fabb
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 6 runs, 1 regressions (v5.10.104-cip3-132-g46c091c34fabb) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 6 runs, 1 regre=
ssions (v5.10.104-cip3-132-g46c091c34fabb)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-132-g46c091c34fabb/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-132-g46c091c34fabb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      46c091c34fabba36aab030f3c3c0d43214e7806e =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62325a50650f1aabd8c62989

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-futex-asus-C523NA-A2005=
7-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-132-g46c091c34fabb/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-futex-asus-C523NA-A2005=
7-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220228.1/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62325a50650f1a=
abd8c6298a
        new failure (last pass: v5.10.100-cip2-425-g0a0d92194f39) =

 =20


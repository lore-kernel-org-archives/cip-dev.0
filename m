X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.70791.1638240015294050092
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 29 Nov 2021 18:40:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PPYGm6Ib;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id o4so18971270pfp.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 29 Nov 2021 18:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WLCpDgniJdR24fADsZcxFDPFcYVha7Eev3ja9Okk6R0=;
        b=PPYGm6Ib2LMV6Wd5wey/Q08ge2slfdnZIyU2xXEb0N83aYkstYvFYEDigoRL9Ng+sE
         83ru7cLE/InbEFoXWmOW0MVN4U1eNV4LGpX2GOCkI/o60gjce25gNfTQNyjy2z9mEfHv
         Bs3E2F0XmkuGIu16ioPXa/yngZo4nM+/amx8BSLF7FRsqdlwi4hzxRkIdi1c3r0mvxSS
         ffYccyknlLktjks1VwUKGHFpR53QPUsrwcgejlGNGWlWluXcZOXHf4qy4JTp8a7xuZ+w
         54oGYtQuPllBYr8j75oeFErGjR9ROc76vuWegUJ+0qQRIYkVXt513qR2IiZYaz0w9F+d
         r/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WLCpDgniJdR24fADsZcxFDPFcYVha7Eev3ja9Okk6R0=;
        b=Bi6sJ5Rf4KdOIH/6qMGZF9YlREG6NRY0W2/xyiTEuXLeBZWhXvwe9bxblYjE8GAo77
         ILAXpQkH36HFe3dvfwE2kdTaZW4YMl6/ZP4xBhCVuTx+rySdCD2RZ+8DjUawTPv434Fn
         iVjvRnzTtIvUbKYhDJzNVWY+p1uSk7ZZHOIdRDGz/13X5VegO2YMJwAPkd+LBP2TOo3m
         dvSUeMGHgUnCP5Tp/5MWtlm8sMf41QdOUmgkxyES5ktICpocWvJOJexELOWOKfUhTMU3
         WRkJ4g/1c0xL+v8GNSpANl3Ot7o+5BhSzm5oAsNxtXih/JL8kzLVA7Jt5jeTUOr6CHHu
         SNMw==
X-Gm-Message-State: AOAM531vMPZUK64mI8nVVYLq3lSkwzPALuGLiggdgzZyVPbSvu2y3IWf
	CJrYGXbggMW1dhFj/rteR/7CQAnjE+S+doZi
X-Google-Smtp-Source: ABdhPJz7nZAzYl5OgBZGfsVtrHfn68nbX9xvvc+u2ycpLnK7frl28b0zRQIIwXkUGaKA+ZJUpEU8+w==
X-Received: by 2002:a62:8fcc:0:b0:4a2:5a1f:6752 with SMTP id n195-20020a628fcc000000b004a25a1f6752mr42432174pfd.77.1638240014725;
        Mon, 29 Nov 2021 18:40:14 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s2sm21520000pfg.124.2021.11.29.18.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:40:14 -0800 (PST)
Message-ID: <61a58f0e.1c69fb81.ac5ac.8c21@mx.google.com>
Date: Mon, 29 Nov 2021 18:40:14 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.217-cip62
Subject: cip/linux-4.19.y-cip baseline: 121 runs, 1 regressions (v4.19.217-cip62) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip baseline: 121 runs, 1 regressions (v4.19.217-cip62)

Regressions Summary
-------------------

platform | arch | lab           | compiler | defconfig           | regressi=
ons
---------+------+---------------+----------+---------------------+---------=
---
panda    | arm  | lab-collabora | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.217-cip62/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.217-cip62
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dc62e26e3be875a7324b85b8274c13a335e610dd =



Test Regressions
---------------- =



platform | arch | lab           | compiler | defconfig           | regressi=
ons
---------+------+---------------+----------+---------------------+---------=
---
panda    | arm  | lab-collabora | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/61a587a0ab3b0079bd18f6d7

  Results:     5 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.217=
-cip62/arm/omap2plus_defconfig/gcc-10/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.217=
-cip62/arm/omap2plus_defconfig/gcc-10/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/61a587a0ab3b007=
9bd18f6dd
        new failure (last pass: v4.19.216-cip61)
        2 lines

    2021-11-30T02:08:20.120053  kern  :emerg : BUG: spinlock bad magic on C=
PU#0, udevd/110
    2021-11-30T02:08:20.129545  kern  :emerg :  lock: emif_lock+0x0/0xffffe=
cfc [emif], .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
    2021-11-30T02:08:20.143995  <8>[   21.198120] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>   =

 =20


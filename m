X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web09.494.1649866940944432420
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 09:22:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=AYqUTlc5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id k14so2284922pga.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Xahni01ykBhUSF1kDqnUbVyIbzaxfe4/FQfxn+NXyaw=;
        b=AYqUTlc5rXb6zvv7RmntwxcGwmrAUd+2UmYjY4N3tRDz/NA9TU9boC/8QJ9IzstsYc
         ne7lefYaX8gFzK6wTC98iHckQ9eHhyWGvZczwuOOBJcvX92ZBFofG49Yky2JbB18W78i
         tguIRDV/dpG8cVvy37JYzu/EwW8sG4GA+g1KXtIFwDFrGph8UHOC+z5Kgx4NthZTJlHx
         UCKl3JxZHIvAf4SXjlcZ0uOZGJANFSLeUka6TI5qKNuH+DBl+cefgcSA+8keGHNGFB2T
         7Rd1+ZAdczBW2HD9G/HKyi4z/Fr9PARGlwleRk/Ddum2fNAM4aPNY8qJM1gg8n9KeBzZ
         oftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Xahni01ykBhUSF1kDqnUbVyIbzaxfe4/FQfxn+NXyaw=;
        b=pozjykhqRLcfUe/NnbFI0e3RaYx+RMz1AOclQ7EmoZvq9NyIylYJtMH82ysn28BOeb
         QBtDOvdGzQWAOrjF3SMXEsTev33vRu/nJYroMrI4qVb732y2zzIGlF1/g7ILd3gP3IId
         /1amc2zjmlhuj/hqgs3F42YKZPKldb31PWY4VNmMZAWVY1Naw6TVEXhG33sh+F5I/FO8
         5+b6u9hBEwWHPkB0LmqreZAs+K9ACjAFU4Ud+gmoKtYSWxloLlWSU80AQB3+za0vEzd3
         1UK6PBMhNQ8yBrhOjkcKjgFgxN3TtDjwv5UlqLqabIJ77oSRDLGh+CZmjROad3K4Owu2
         3LXw==
X-Gm-Message-State: AOAM533VfM14H5Itf7scfqWtNLIAfS635F4DPvso6SVrDxf9RxL9jJKE
	iVZh00UlOtJi6m5gfJ3G3EH+wLJrtAQL24V4
X-Google-Smtp-Source: ABdhPJwBcVuOf0MdAi0NFN0qiTUbU7IGitTQlwLk+cidT/ZAldC/40zGbn2+HUBa79VernrhwNk/Yw==
X-Received: by 2002:a05:6a00:1a10:b0:4fc:d6c5:f3ed with SMTP id g16-20020a056a001a1000b004fcd6c5f3edmr10520121pfv.85.1649866940310;
        Wed, 13 Apr 2022 09:22:20 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a16-20020a17090a6d9000b001c9c3e2a177sm3397203pjk.27.2022.04.13.09.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:22:20 -0700 (PDT)
Message-ID: <6256f8bc.1c69fb81.b98fe.8645@mx.google.com>
Date: Wed, 13 Apr 2022 09:22:20 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.109-cip5
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 5 runs, 1 regressions (v5.10.109-cip5) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip ltp-timers: 5 runs, 1 regressions (v5.10.109-cip5)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.109-cip5/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.109-cip5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9c39c65c57028fa2c58fb7579c15f9cb67571acc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  163cca9acb71d06492836a667a53554ceec37639 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6256f0181a896386ceae06a8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-timer=
s-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-timer=
s-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6256f0181a896386cea=
e06a9
        new failure (last pass: v5.10.106-cip4-66-gc8c4cc5cdb54c) =

 =20


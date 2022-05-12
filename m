X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web12.442.1652370905940437325
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 12 May 2022 08:55:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=2sAqt9Ud;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id a19so4779074pgw.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 12 May 2022 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XqE5LGmoaXDPB2ZDVGjh8Tpc4BjNAwONrt1V8RYcDUg=;
        b=2sAqt9UdHvOTA51sHMytZ7FkfgfDXVZiwr+duo6lYqnNSKVW36Iv5ohOY2qtHym6xf
         cKOOp/IuZByLV0AZfaZJkWwjzFKIidB7yGHP0RnkrAcIv40nlAP1kjgBwAAxtPx3VhkW
         hko56yGmHn+RAGZvSry7q4XW8QdjEvX+Oq6Y5xZA5NvrqC3+ID7JUDCeKq/6brRkT3Tj
         uJpPRclOLGQ7EfonynzVO7PXmLW8OFBJNwJYdvfkjqzaVWN87zDSjh3gLcNlJYY5fVfg
         W/POE1aUOOZ/OmlXR9tA+ddKj64wInmdXgWhjNw3wo1Ig233ULvF6QAHYVdMvyOw2aQw
         /2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XqE5LGmoaXDPB2ZDVGjh8Tpc4BjNAwONrt1V8RYcDUg=;
        b=pTI/Y8+D7bg89qH4NtlQVMxWMtWTbT8c1zayKNkcV8K1G4GkBj8+Oj2nE4to/8d6EJ
         7ntBuHaifIjPXLi2fkUO80Sv/+WKCnot/w3SXQPrHeMdEc3JceUFqjTA8prkW3Vi7bs4
         eXxVgcEe7IbVKic54LartchVNMaS8+CenvpWC7c6Ombkqg1bfVNp4BIDSoB0ZTwr5SDo
         C6Kex+XMfM+2q7XYAB0R4BS4jHwDgMqflcoPfgYOuuY4vEh3/jWezTy+jkiYMPRqaeW/
         lq+l0Nr/9aHIztEDJHCWEz9ePhRv5PvizZBmcyivTjMQfBcpDxuYgp/HfuLHBOp9bApK
         71bg==
X-Gm-Message-State: AOAM531FcgqOTAsaxkNDPclZP1eaasRxoJMz2JqkB3zGRa+aKUsuaSmO
	MtkKdpmzvnxPMVJyx4NqXCsvCIfv/U8AhIMmbAo=
X-Google-Smtp-Source: ABdhPJybwVuuM3oaNRV2ipTlUpSeup68r2RjG/PKMmFpGOb8r5PyfgcIED2qmVAKnEMxxeyFhL8+rA==
X-Received: by 2002:a63:5510:0:b0:3db:8bb3:6059 with SMTP id j16-20020a635510000000b003db8bb36059mr266028pgb.328.1652370905193;
        Thu, 12 May 2022 08:55:05 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b10-20020a62a10a000000b0050dc762817dsm9473pff.87.2022.05.12.08.55.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:55:04 -0700 (PDT)
Message-ID: <627d2dd8.1c69fb81.6f6c4.004f@mx.google.com>
Date: Thu, 12 May 2022 08:55:04 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.112-cip6-289-g2969e096d186
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 5 runs, 1 regressions (v5.10.112-cip6-289-g2969e096d186) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 5 runs, 1 regression=
s (v5.10.112-cip6-289-g2969e096d186)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.112-cip6-289-g2969e096d186/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.112-cip6-289-g2969e096d186
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2969e096d186c13cc3c3fc8927147105d46895c3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  0f67c9851a9043d0ad68cef4648d103ba7908480 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627d2890d99293164b8f5735

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-289-g2969e096d186/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/627d2890d99293164b8=
f5736
        new failure (last pass: v5.10.112-cip6-88-gf3397cadb2dd6) =

 =20


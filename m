Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555D5C001DF
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 15:22:39 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.57063.1697815355079229778
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 08:22:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=HaUgJrAZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so815664b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697815354; x=1698420154; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4p3VLwmoP1SWPkOvd36LDcOBXeA+8ntBQxEIdSTxPc=;
        b=HaUgJrAZ2NUO105TRctXhsBZprfCIf22440THtgSAKbmBE1LwrUaQ1p8QWI/Qe7aZA
         Jvh5vs9JYppkuARFLkxR9j2cosr195p1HB6LqCzTBp580HozdTa9W+EvJagiR6mc9CCi
         YsJlzfIAg3ImMkmoYbYjYi2a7fFOvEzhn+HTKh2qkOiOVYehDAVN6PbzVG8j9cMSR+Nr
         vmemkAvL6bjNjFmLfKszwkUEuL5hkPEbNcan8KNfGTzqglOuqWQTZZt8UWYng5ricaoS
         eekU4H/doPIcT0nu6rpH59LsliaZ9/G6ypqtbeA/ihCft3lCO54zfPKU4pkw8z1exutV
         vImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815354; x=1698420154;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4p3VLwmoP1SWPkOvd36LDcOBXeA+8ntBQxEIdSTxPc=;
        b=EbfQOa63t3UzyZktRVeojsFXTU7H+30+6yHyEIa1C23palPJj4szzbkHCHtEqUVrOq
         lcf3VleqEsEHmjeUuwuK2GP7+sY6dRF+tCTLDyx6mzddjkuipmb/nZSD4pcEqcf0Esmv
         MawNuqBzVwkZZJ2HCm+2rxh+7PwWnr1eeZXqVHhOoyt+pMW7BypGDGL1LujHb0WDCN+M
         Nv6CGPnxPxQciqLvXQE/MZx9zGa5DmB3ZO7hk2phFzDpsSFTGPH4aoCP1R6bO314ePFl
         bMC1EC2SD8bQNhxmSEl9QN9MSPRLtswyAbTyk2gqqZqc0zTfW7TGi5fdjrqc/Cm+LSsa
         j9Sg==
X-Gm-Message-State: AOJu0YweIzItPB1uoLLFgyzM+UjbuGKGE5SVGhL4Xe6EYXw0KbA/HFSm
	tESHNDA9yxlAVV06z59286KL3j7yO5V7g5sOw3V19g==
X-Google-Smtp-Source: AGHT+IFWLyO8i0KPFomJIuFZ2yKAzpl7AObhsyh42zF4VCdifu9M1ltboMXYMOH1Nwk+/DRiSmFi6g==
X-Received: by 2002:a05:6a00:a29:b0:6be:4228:6970 with SMTP id p41-20020a056a000a2900b006be42286970mr2348322pfh.21.1697815354104;
        Fri, 20 Oct 2023 08:22:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056a004e4f00b0068620bee456sm1660848pfb.209.2023.10.20.08.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:22:33 -0700 (PDT)
Message-ID: <65329b39.050a0220.c07d9.5ff3@mx.google.com>
Date: Fri, 20 Oct 2023 08:22:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.295-cip103-rt33
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip-rt ltp-fcntl-locktests: 8 runs,
 1 regressions (v4.19.295-cip103-rt33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 15:22:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13416

cip/linux-4.19.y-cip-rt ltp-fcntl-locktests: 8 runs, 1 regressions (v4.19.2=
95-cip103-rt33)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.295-cip103-rt33/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.295-cip103-rt33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      28d064262557c550e33da563b323e56c214e60fd

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6532900550db94a108efcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6532900550=
db94a108efcf01
        new failure (last pass: v4.19.280-cip95-rt30) =

 =20


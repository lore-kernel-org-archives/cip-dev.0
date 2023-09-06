Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF009EE14AF
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 16:29:31 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.3414.1694017765364209265
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Sep 2023 09:29:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=RIQLjwg/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c337aeefbdso27320715ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Sep 2023 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694017764; x=1694622564; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O6BfjfBREL3lVYaJpC0MnQny9yY11S9YYOpdYXA3how=;
        b=RIQLjwg/oCZBX7gmMRBp2J7dDaFZPhZBT7+OGgMDKanH3TNv+MLb62lyyYogmGQIvg
         VvcDh+pEKZ7EEDZS+UP4yBrj89wnbUBE7DoUACxc4XPH/0VNjATlqrsuYkzt/huUuEQl
         VvP7YbAbRHD9S3tCLAZj3cuS1C6W7fsH8HJrV83NE7cmmNeqBtsgX3/pX4YWk8EpRWKw
         iy6Rx/CDDjjKT+UFZVZPTuQ1pRPVbfsFto1scAWdgwLt7Fdcrzcc0oDO81zE1LRPSpgm
         qXzv4xULPtm0Bh0UGtm4eIbvqadpId7Yz57S5tennmj/8zCRQPprsCK6W2DNSGRDIL0E
         ArPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694017764; x=1694622564;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6BfjfBREL3lVYaJpC0MnQny9yY11S9YYOpdYXA3how=;
        b=dubugmrnXmKEZjfIl4E1wkJm0uyNHyYeDrzpP9yXHwb6QolFbx/ohH0/kcpBLcXKJm
         kdPPi9fejfRdae7yrWa2Au6nuoqOtVC9pZ3mJkCuXnaI7oJ/3eMzdhiG5G1n9YOiScRU
         HfcTw5uZ2LzAGXJyBTtn0xJbkGz+ioLN+IH1Vk+oFOPtzFubOCII1MW3jElvs9qht4+b
         qZynGnWMHzpxbds4JeUZaNzWQbCl5s+Y3KL8QfCQnqXbnG1Ifj5nVb0AyhKy+lpkBKFd
         mGlz3lofnVrIQShF951Vu/bJz+9DGUkQCdKwb+gAsDtXTzJgeWqdpw9hQsZzzCeqehT0
         2cEQ==
X-Gm-Message-State: AOJu0YybbhAFSh+3zR1RlWWh9mMALTAg0+AAYA8Ob/agv6nyroLaPhY9
	DIVMZZHmBm0pCQ5ePQYtq4UrrAzp3myBQ1CMDcalxQ==
X-Google-Smtp-Source: AGHT+IGt3iH1cSB+CT4+mSmpkaNRECgpicATMv+VaKbutT5CPMQewGeEiXryvCSeK8rEBjqL4oGWUw==
X-Received: by 2002:a17:902:f54b:b0:1b8:6987:de84 with SMTP id h11-20020a170902f54b00b001b86987de84mr21719162plf.48.1694017764292;
        Wed, 06 Sep 2023 09:29:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001b895a17429sm11260074plq.280.2023.09.06.09.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:29:23 -0700 (PDT)
Message-ID: <64f8a8e3.170a0220.8fb5c.82ee@mx.google.com>
Date: Wed, 06 Sep 2023 09:29:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1638-gdc4a7f7fb55c
Subject: cip/linux-4.4.y-st baseline-nfs: 10 runs,
 1 regressions (v4.4-st20-1638-gdc4a7f7fb55c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 16:29:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12996

cip/linux-4.4.y-st baseline-nfs: 10 runs, 1 regressions (v4.4-st20-1638-gdc=
4a7f7fb55c)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1638-gdc4a7f7fb55c/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1638-gdc4a7f7fb55c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dc4a7f7fb55c24f25db88faf1beacc8125660b8e =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f8a1e7d945713cec286d79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
638-gdc4a7f7fb55c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
638-gdc4a7f7fb55c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64f8a1e7d945713ce=
c286d7a
        failing since 156 days (last pass: v4.4-st20-939-g5ff13a6decb9, fir=
st fail: v4.4-st20-1098-g8d34bf42efd9b) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193E1C07545
	for <webhook@archiver.kernel.org>; Wed, 25 Oct 2023 18:30:01 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.51433.1698258595932877154
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 25 Oct 2023 11:29:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=mC0K7qck;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5b5354da665so63025a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 25 Oct 2023 11:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698258595; x=1698863395; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SuFC0OsOk/6L/qnJlnbBTq0ebI4tBb6NTvgFDcmN1FU=;
        b=mC0K7qckkytu9OJ/d81aftTTL0efeH/1mSdqgjraq1H2UYWkgO1meGfczpDO/LH/DF
         yQ2HFJMAlEVU3oQ7HwkqMEhaDeFKV+fWQCCH3ArCxato1FmFu4YOMtObsODVg8Uhu+4f
         ccWSrClviwPWRKFk1/EQpx6t8EtsoKp0blHIKCbh2x5IZ0F5b2ba2MvTdlP/aa5ODw7+
         SbwmxXOCotG46R/5wI5M1scUzG5cTpvJeImwrDyDx/INyQUHUxEodhckrT7AWPAW20Uu
         /3B0vjZ8g08WuGM2Mh9CFLDIKjbOwTk39pTNbAj4UtT2NW3lfQeM86LNJRPT0I4TJmwl
         LEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258595; x=1698863395;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuFC0OsOk/6L/qnJlnbBTq0ebI4tBb6NTvgFDcmN1FU=;
        b=rEwqQsyqlJYUkZz+5agNCXeDEQQu3zg94HSImzsGHREa//bGDNV69TqE6iLX2m9knb
         UaDHv242AIXBQFcUCFj2ycZUwS4RiLtmi0tpZPc8J7yTmcJoSdPu4jR5j+DaoPuKRFlk
         ijpMJUur+4CgKoYDhR2zxg+2QwKVuPMoAUHvFxmxbgJinxZ3NhyWhBKlsf4CECRZXMpp
         CBePdBPvqg0tZ5XAKjrDju4T+ojx91hWmixjdvHmZWmehKzSjx2ju8qM7Lgiy4Bw5uAC
         vcoPVkZWjjWgKJoHXrd7FsGBAPUv2+mmCoDIpxTVULOZf82Yew3unBuuWGThTWwVeMOt
         lPsw==
X-Gm-Message-State: AOJu0Yzz2R4XGD8SVJDFJoDPZxWIvt5IoXwcX9yYTGPKb+M4ZJ0w21uG
	vlt0ow3u/fIVNKsxZI4MNHyhbP9yvHpUKM8C3gg=
X-Google-Smtp-Source: AGHT+IEWDYS5xLf0haz6cvTy2dAyqpG+Joq1TsEVRD0nwVF6IHduexcdapW/9RT4N2esc0fbTjSqfA==
X-Received: by 2002:a05:6a20:1591:b0:134:a4e2:4ac8 with SMTP id h17-20020a056a20159100b00134a4e24ac8mr7149245pzj.39.1698258594722;
        Wed, 25 Oct 2023 11:29:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x125-20020a626383000000b0069346777241sm10424944pfb.97.2023.10.25.11.29.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 11:29:54 -0700 (PDT)
Message-ID: <65395ea2.620a0220.af851.384c@mx.google.com>
Date: Wed, 25 Oct 2023 11:29:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.295-cip103-193-g33550555e507c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 110 runs,
 1 regressions (v4.19.295-cip103-193-g33550555e507c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Oct 2023 18:30:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13448

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 110 runs, 1 regression=
s (v4.19.295-cip103-193-g33550555e507c)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.295-cip103-193-g33550555e507c/plan/baseli=
ne/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.295-cip103-193-g33550555e507c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33550555e507c555c8f8e194b8778427898d1c3f =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/65395789c32e331311efcf1d

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-193-g33550555e507c/arm/omap2plus_defconfig/gc=
c-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-193-g33550555e507c/arm/omap2plus_defconfig/gc=
c-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65395789c32e331311efcf4c
        new failure (last pass: v4.19.295-cip103-95-ge42cfc8bb88b7)

    2023-10-25T17:58:59.271345  + set +x<8>[   10.553441] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1026508_1.5.2.4.1>
    2023-10-25T17:58:59.271851  =

    2023-10-25T17:58:59.383288  / # #
    2023-10-25T17:58:59.484986  export SHELL=3D/bin/sh
    2023-10-25T17:58:59.485523  #
    2023-10-25T17:58:59.586601  / # export SHELL=3D/bin/sh. /lava-1026508/e=
nvironment
    2023-10-25T17:58:59.587064  =

    2023-10-25T17:58:59.687967  / # . /lava-1026508/environment/lava-102650=
8/bin/lava-test-runner /lava-1026508/1
    2023-10-25T17:58:59.688988  =

    2023-10-25T17:58:59.694896  / # /lava-1026508/bin/lava-test-runner /lav=
a-1026508/1 =

    ... (12 line(s) more)  =

 =20


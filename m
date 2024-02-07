Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A84C4828F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 17:49:28 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web10.4301.1707328161554194175
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 09:49:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=y9oxATD4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.45, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e2af0bc0dbso473061a34.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 09:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707328160; x=1707932960; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9PC9028v0wTuRdDY6O4pRPfRS65GZYZ8IrFPIzPGjVM=;
        b=y9oxATD47evYzT7LNeu2vIX/eEE4x+uxq9ATfYKDWYcvuo36LFeIfKxqVD9+deZaef
         aQ6gdRNuNt79bMKONuwNSSSWZKpOBsiTqaITmwF/BQHtLN7o1Ku6n384uBejgUo/X9+a
         TtYEkVxVJpVdHgWdh+eWoQf1L9mSBDvcOP8WlLDfGXC5Bb1dJon8d019L3PvrbjUc4Q+
         ktvgbjQSAb5U5Rr+X7iyL0zJILDLapfma8sHJSzf7rdILK5tJvIqAOkw2sBDokSrMoHM
         9oHbngUn3h/E2unArTjN8eH0SUGUQFsUVpQhKBPays34bQNtLR3MbH2Uq7pdBGgNTRER
         szMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328160; x=1707932960;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PC9028v0wTuRdDY6O4pRPfRS65GZYZ8IrFPIzPGjVM=;
        b=Ijn8tXf4j1ZkFtkzbn743bQOJhzN6RoXXxAwygTC5DBCHmFGMY2Dcxq/7BTQms4Qzx
         Nyjrwjec56O+sexN9EqGiGTha5MinjrT1t8QMlx1+EEdC9TkzR8hHt3DNSOvQv/Hxcu9
         Xr6rxSrul6Jga83++N9n2AHKMPwvB9FySs47S+85UX3LpqRan9Z/yOxHikm/7SIsPeI2
         hIwC0DEmMqTbWr5knE0Phi9/R7Kf3yd/SBK6KRaksqn12dG/fzBSBJbpfYagcuPDEdHc
         ggQRW9H/nWdIKxRRNzy66Hdc8P34LGdQNStxRwtUiHwsprKwbsAqRZn9FBc1WfFQVnQ7
         q7Fw==
X-Gm-Message-State: AOJu0Yxmnqn5fs91NE7zmehMUkfslFDbE506WX7f7pwETY9l7u8U64ys
	SlxroMkQfVlqL8e3BujCvVxCc1p12EyZb8O2riIN2g9r3aGvoyYhv6ZZPNJ88m/7umqu0bJkOKb
	GZko=
X-Google-Smtp-Source: AGHT+IGbciApgpBSagVdmHZwCc/T2evQIoJ3w03iBkR1TCd8dmEMYSvOmt9RjmDB60XqHFmj9ZpbIw==
X-Received: by 2002:a05:6870:b49e:b0:219:5a6:b6cf with SMTP id y30-20020a056870b49e00b0021905a6b6cfmr7256075oap.19.1707328159923;
        Wed, 07 Feb 2024 09:49:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s186-20020a635ec3000000b005d651d4236dsm1904471pgb.86.2024.02.07.09.49.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:49:16 -0800 (PST)
Message-ID: <65c3c29c.630a0220.f144b.6768@mx.google.com>
Date: Wed, 07 Feb 2024 09:49:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g57b839f015944
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs,
 1 regressions (v4.4.302-cip72-1251-g57b839f015944)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 17:49:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14894

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4.302-cip72-1=
251-g57b839f015944)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1251-g57b839f015944/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1251-g57b839f015944
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      57b839f0159440df3a9c4b22dccee20e801350a7 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ae26e40214d0888e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/65c3ae26e40214d0888e1e7a
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =20


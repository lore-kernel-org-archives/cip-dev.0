Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDF8C4828E
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 13:21:37 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.13626.1706707288465676505
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Jan 2024 05:21:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=yw6irrVZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3343272a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 Jan 2024 05:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706707287; x=1707312087; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X2xWaVYVJwDFUR2B6Nn/6h4Tl/j12J+rrPiR148p67g=;
        b=yw6irrVZlPpiLYcPCdonARsJHtAyLqwBhNrIlVpTmoT25zsIuVtxisv63fHvlsZ/6a
         2p34dhLo7pCQUvNu4ohn+lB6koaRpmOE7akz29wOJ9FAMD23VGmufyUZ+H7qzzyJPdy4
         9i4TQEht6jB7Wtzu9Xf456domrhLn+J3fwabbLmwF06J5fmdhOn6kUUQUzVC2uzPX/Dc
         8COnLldk9tgWgtwRHUGtG7ds6cHHaApSgkbkTss4JdHEsDpsdqctxsEPiO75tNKo91Bz
         aEixC+YdKtx3FxolPh53tAn2iDxDpbNbUkykKVB/QZrHQZvlXGtwKLRhECc04s1fK1Yq
         i5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707287; x=1707312087;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2xWaVYVJwDFUR2B6Nn/6h4Tl/j12J+rrPiR148p67g=;
        b=Ov7Dx8QiWI7+KnEnSFPVA8Xfo67FG47X91JsRYiRCQxh2owJr97uMSEx9EVgBg4kV6
         kdu0yzJoM5DKLlinYbHuAw2838lljgBv+jM0IEgb/RZ3C+Qi1oBaSbWWHZytN7pWclVm
         RCAHM3Eh4MNC/EkH7UE88HnppDUZHJQ1uSrrWiMExjqSxz3Oz4zuuiPc/MBS/i/uFh75
         g+/bjzRhgxD88uS9t9kB7Blx880IcGR1Zqy5Y4seifK1dJnh2olhrfhlEP/rHbiic5Ab
         osMoSLGV2PdSPf9kaFIQdH/846RhnffVDIh5yZcKLVwSBCZaqNz4PoY4vdQv9aRBNFu6
         6WKA==
X-Gm-Message-State: AOJu0Yw6qZqS0+2VyWL0XZxTxztbeXdBKoKIbI1Ya1EcY3aAQLDwWQZa
	BhKstFB0tbpNG8g6bhIUjjaUACQwKApWi/hRPMGsYE/RA7ccQoOEy+2Cxol7Wpa9dQEn7VPZke9
	5
X-Google-Smtp-Source: AGHT+IGT3irG7nTz9E+Y82nz/wVfbdPCj5VCxrlE2JEtfSt0msWovk439f/1PzRa6lk+mQaPUUuSMw==
X-Received: by 2002:a17:90a:e650:b0:28e:7b94:78dd with SMTP id ep16-20020a17090ae65000b0028e7b9478ddmr1466605pjb.25.1706707287044;
        Wed, 31 Jan 2024 05:21:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id cq13-20020a17090af98d00b0028e023be116sm1433683pjb.49.2024.01.31.05.21.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:21:26 -0800 (PST)
Message-ID: <65ba4956.170a0220.26cff.3382@mx.google.com>
Date: Wed, 31 Jan 2024 05:21:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.72-cip13-32-gf60d2e8cb51c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 8 runs,
 1 regressions (v6.1.72-cip13-32-gf60d2e8cb51c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 13:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14564

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 8 runs, 1 regressions=
 (v6.1.72-cip13-32-gf60d2e8cb51c)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-32-gf60d2e8cb51c/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-32-gf60d2e8cb51c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f60d2e8cb51c9da65ffcfe73144286c27725ceea =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65ba315619d04f989d00a0af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/kselftest-fi=
lesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/kselftest-fi=
lesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65ba3156=
19d04f989d00a0b0
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa) =

 =20


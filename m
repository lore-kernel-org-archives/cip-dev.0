Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43874C61DAB
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 20:34:52 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.35383.1700685283876842482
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 12:34:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=mB4w1rY5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6b2018a11efso241269b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700685283; x=1701290083; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VxPDvPb/TG5HPSX1j8DTDxa9RS4KWFykdQmZaiM1yaA=;
        b=mB4w1rY5WdCMW4XgnA6LBuBwb5IoUX/FdDiuM1yJ9VNIIvVlg04ZXiRLKAmwjjFunQ
         chkZOQc8prY8Vp3lpyDBL06oaOpKLtR6FXyULbHJQzsrbbtu6x3AWVXqOYgdArQVBANQ
         q6kzmvTJTXylsZh3CUKVqd2w09/Ayx1jdnZQHo6SNAl5lECO/259ykmDyrtPYJ6NC1R3
         +kxLsyMZNLPYfb2GZ9dueB/y+oHEJPKnx8b5KZYEHpaaVeYMcOMFwY3esjkdad4x7QtE
         SMg5kDHODCK4awyYVNBkUL6PI4LtEaHoIeaHvjeOxwdAwaNHjUpu9J6vfl0Y6y6RmIEg
         9+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685283; x=1701290083;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxPDvPb/TG5HPSX1j8DTDxa9RS4KWFykdQmZaiM1yaA=;
        b=rlJAFPK1Zvk7Zj+TypGaVijMrJ7gCd7s3m0TOmT+evMdiTraR5kCGxnv3aRhQJXhAi
         Wrh4eOUbkoDXwi3KzjVcBPus4Vnq1KDe5S/UixQaAc+XOatbH0zwQYNSjhUlKNv8rRVF
         lmDmu83IOaeFDOVcN0fsbIX2Tk5Aa0ElsTN8NFDo98JQytb45c5y4IEbxX8t1x+pznc/
         44P4UagRL6TXD6AgKsg4ZF/qcUiILjiAFZ1N4cBnWjIMrdTpgaeWgORGZP0Azf0OAZPs
         crKPqji3uuW6TR4ZmStAoOiHjoGwJrOjRX4m6k8vIEEhzsXnPJVtlwdMdkJ/hNZERzuy
         L7ZA==
X-Gm-Message-State: AOJu0YwErNAlT0BSZLGEMaTOaH6q8bjGfed7wa2MU+0p7gTN4+9k7XJP
	LP6eKZIeei8fs5/7thV7OGvH+1ONn+RIZqpLnSU=
X-Google-Smtp-Source: AGHT+IF9jyOcy+YYSOZpsyTaDMTFtqNOWu0tC1xLgm44a63CmVptQ+wln855mTTxGqcAXymDU4UPLA==
X-Received: by 2002:a05:6a20:440d:b0:18b:47a9:66e9 with SMTP id ce13-20020a056a20440d00b0018b47a966e9mr3713828pzb.40.1700685282834;
        Wed, 22 Nov 2023 12:34:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y194-20020a62cecb000000b006cb7f9da229sm134549pfg.202.2023.11.22.12.34.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:34:41 -0800 (PST)
Message-ID: <655e65e1.620a0220.a3a39.0bdb@mx.google.com>
Date: Wed, 22 Nov 2023 12:34:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 9
 runs, 1 regressions (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 20:34:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13646

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 9 runs, 1 r=
egressions (v5.10.200-cip40-188-g33d0b44cd71d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/plan/ltp-fcnt=
l-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.200-cip40-188-g33d0b44cd71d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33d0b44cd71d9f81944784e605bc1def7fa0b71e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655e542904819494dd7e4a71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/655e542904=
819494dd7e4a72
        new failure (last pass: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6473C54E5C
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 22:46:55 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.9743.1709765210932898910
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Mar 2024 14:46:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MiRWUPpB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dc949f998fso192029a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Mar 2024 14:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709765209; x=1710370009; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka5H2dI9KXO2DWe5o12BALgo4VMn5DAmR1KlfaENZQk=;
        b=MiRWUPpBvNnvoxn56pY+wLV3PR2eOKXe7MF4FlVMUXRlQoZyUM3nsf9OStshayLuRw
         GCn4K6xqXfpLpZFmrKUCZemlyJ6ZwoRdpOkbD38qoSTeVdGS2/GwOuZOLmj7eCHhW7Rx
         jRqThnX/JRAmyi1leW0/Io7dzHcL7W6zkysTD1UcPIrU+NkWDa4ne2QxBbChHiUlqeiu
         OS0ONSK4KYuOAuQSr3Cyjxx5q8MtaMqDHyOUwz+QAkujWksXr2eLxhzH8WssE0WPrr7E
         LZsxBX+wuRftRgZXY4HhPHaKF+3GyIl4tgJ97hx+r+U/42pBZkQWEtcVdr+559jyPLNc
         H+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765209; x=1710370009;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ka5H2dI9KXO2DWe5o12BALgo4VMn5DAmR1KlfaENZQk=;
        b=ONFuooaTRGF5Vn4AC2IgVxj64KHmVrT+XZOpXy6HKspYsyzdXxKVQsvJZJqZGtoN3j
         2RCN+2u9ChULAwjDwlngF4f4wLowttt31VEyVoRlNfYITJcIBckp+63cP+qhYt85TpMQ
         jH7qVf+pjhvhbbGm1jKeJ2wKrBzSjifSNYJVBW9AdwaLVjc02IaDQzQitwu1J5PKm0k5
         UEjHnsbB0/AQj+AtjNUesNs2zYVWL8SZHE4WoqN4ZBd+RjZks2B0dT7tA0/PU1kz7m6Z
         HiNu6zYqhY2QQiwF2kZvIc1n77S1F2XN/KIolEVKUOAv3iNHPQnUsZ5fUYk5qBVC4PYZ
         9D/w==
X-Gm-Message-State: AOJu0YxTD6ccyJxDSL4vqN2LJhx24G8E+71TyaBTCkNn12HYZC70QMt4
	x8CE/MfrFhZ70w1vZBHXwm0ev1S4mWyP93tx5gcdnApSr/+7yYWdCDQwZU4faK0Zs6mTAjy2VBB
	cZ4o=
X-Google-Smtp-Source: AGHT+IHzrZTMrxDQT87JuKr6gniTqi0jDOF4lLF/AIcF3dSZZNn0FU3VaK2Qa/SsldT3H3E3IA0Dzw==
X-Received: by 2002:a05:6a21:7888:b0:1a1:67fb:924b with SMTP id bf8-20020a056a21788800b001a167fb924bmr2887049pzc.28.1709765209571;
        Wed, 06 Mar 2024 14:46:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090a394400b002989864e50dsm2178183pjf.0.2024.03.06.14.46.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:46:46 -0800 (PST)
Message-ID: <65e8f256.170a0220.4d046.438b@mx.google.com>
Date: Wed, 06 Mar 2024 14:46:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.209-cip44-594-gb47da48f3bae7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 1 regressions (v5.10.209-cip44-594-gb47da48f3bae7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 22:46:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15246

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 1 regre=
ssions (v5.10.209-cip44-594-gb47da48f3bae7)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-594-gb47da48f3bae7/plan/kselfte=
st-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-594-gb47da48f3bae7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b47da48f3bae7f477104b0c214451338a6a343df =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e2f0b24f183f504c42e5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65e8e2f0b24f18=
3f504c42e6
        failing since 125 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20


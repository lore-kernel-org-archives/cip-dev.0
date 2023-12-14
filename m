Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEE4C4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 01:41:44 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.12277.1702518102146017873
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Dec 2023 17:41:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TYB+oi8Y;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d350dff621so12480795ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Dec 2023 17:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702518101; x=1703122901; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oU/gzRwGTC2nqlS6NwYfvC79ALrgjWeAYC09zhocBOI=;
        b=TYB+oi8YkqD5sy410UmY60lsfOfWpqv8KLlhXC8BDUlu5+9b5qbHTbeY5fhDUK1SQG
         a50Uo5AR07Z/qlOEeddJs7HEsSsiGaloc2qM3IONdWFZFQy3UKtK8wE4L6ta4WzJuOpn
         ata1OcIH19nmuGplPnXliiuA6If8335nrz5gaVsqx35kpStLvAnJuzTK0d/ghOJqeFvb
         FrTn16pc6k0MHdEnpGTpDYKOh1dQYuV2mojUA231Eb4SeS+FGWBPh7/pOpaWMRcEkaFp
         lSawQwcEfb3mTiLi3vPXmLS9lNVBVfhrxhqDbuNKmaQ110opsaLs6MDKRVxAgxrV3WeA
         11/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702518101; x=1703122901;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oU/gzRwGTC2nqlS6NwYfvC79ALrgjWeAYC09zhocBOI=;
        b=Pu4gtWbRm7cbuf02fFGgM0vP42nC4OvBX+oUooxdMR+BjkpbtWlGL5llFu6rEjKanE
         9Ez63kudJOadnuvCvHDe59ZXvrOYLI2cqIJ1MflaJNMR9fmoOJQflXHIvCOQNOjx7D2K
         TUeJAX7vuXaQ/T9KuUClS5wNq25JLhPRyXUDjCxhfWl8o89OvktWnfZei3wiHUKWmSaQ
         TrmyFOgMkZLZWeol84XyfZUZvPhrZutn4vU/lXqL6ZSAb/xLI/G2rhsxmJ7fZUgXGjsp
         IumatvyOMlrZVFGEHecT62mCO3W6EoGuR4sefMTRdxhraKH+Y9HjcwG9g7k5YQH/Rk3s
         eHoA==
X-Gm-Message-State: AOJu0Yz3QCDbcvo7LQmbSGIhv6LgVCqPf9xnLBZelIGQZ+J3igor+DxX
	4yfuRrZRGmgfX+t7zKQiu4FWc1EwKRWQ/6IVGUH/hA==
X-Google-Smtp-Source: AGHT+IFP8LSuVLIjf7ZCQBQ6zoz8/fSbvRYVgsCPqDXrKn7R30mdFSxdigdeX3XuF1ziJkX3PJweaA==
X-Received: by 2002:a17:902:e88b:b0:1d3:5f5f:51e7 with SMTP id w11-20020a170902e88b00b001d35f5f51e7mr1457958plg.91.1702518100445;
        Wed, 13 Dec 2023 17:41:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pw3-20020a17090b278300b002839de4d348sm11891681pjb.9.2023.12.13.17.41.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:41:39 -0800 (PST)
Message-ID: <657a5d53.170a0220.a12cc.4d78@mx.google.com>
Date: Wed, 13 Dec 2023 17:41:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-473-gc43d7b7bbe83a
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9
 runs, 1 regressions (v5.10.201-cip41-473-gc43d7b7bbe83a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 01:41:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14077

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9 runs, 1=
 regressions (v5.10.201-cip41-473-gc43d7b7bbe83a)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-473-gc43d7b7bbe83a/plan/kselfte=
st-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-473-gc43d7b7bbe83a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c43d7b7bbe83ae0f7e001ac115b838d7cd1afe79 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/657a523c2028449b07e134b7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/657a523c=
2028449b07e134b8
        failing since 175 days (last pass: v5.10.182-cip35-191-gf4efde51295=
9, first fail: v5.10.182-cip35-289-g3c0549540706) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F99C47258
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 14:11:05 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.7444.1704723059799023977
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 08 Jan 2024 06:10:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=XTcpHjJI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d98ce84e18so1593640b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 08 Jan 2024 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704723059; x=1705327859; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bXy5F2cU6RLT8HUK0YRR2aeupdwM77OPgEGKB87YYok=;
        b=XTcpHjJIiwqLufRpim7Mb/I7Hrf07jA0sdj5ZI78RP50VQRruLNqcjBbg5Wqbcggpn
         oMDAAuTml6sUfI5rWpLLhi8Gn2b6E8188xn9bDwW81woGzgraNXkiEcy1zK4VZWLr4zf
         IAWKTV8xQ3FL2n7E244SIdJsNWd34RbB1T69l/gTSS15sx1RL3aRlp8zSbLG5fyrfYVP
         tO7lRkWkwTFFncmYgns+2cKtqVd4vIUzsKcIvh5JhrGCiwP8U0v8ZkTXePKiCUpKjCdZ
         F7jTUg2ZdQ85zjL324pTwc8aDcgtU4BMZ0BuVZSnWD+a5n78x0smTUMYRa2qDaqKudb3
         N2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723059; x=1705327859;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXy5F2cU6RLT8HUK0YRR2aeupdwM77OPgEGKB87YYok=;
        b=V2lTVmtv3ERcf3emolqZugdObD967tHoaogo40kc9Rd5VPCpX2a//LmdDZi0XsBocY
         cjiFdwOi5pTNgGJ7YfhwIwxUCxtFRggfA0xrKDD9PZo+e1iRBCV2EZo+ukrjyn1VlxxS
         EfODEaYmoYHXFnwcYDyafFiOjfItWLJOENT3IDCRj4YKCj+8BUWrWRhQHIYigB3ihc/e
         aAKH95vft1G6jaf8vB4JISZrZuVMi32X6Vi0GBKDeDp3pNZNyirUm1Uwr9zTpI69WtEG
         Qf/Klyww9gCZgoyE5W0RqX2J4WtsWWozYVnjHdug1CzPiCmNC31DYhXNVPLLuyCzGEck
         4l8g==
X-Gm-Message-State: AOJu0Yyxrv9uyI3XvyD0lBA09+7s6lJsHHWN3EBzCXD82Pc0JaXs+nsH
	+WJINe7+5DYYirFX/OGHnAIKPrupUe0hqP+WQYavne8VdDE=
X-Google-Smtp-Source: AGHT+IHheo6+JgHYaeYM7/BZ2ZBeM6F5uezXk0ZovEcL5e/r9Rkv8OJgt6Pn/1wJFBaNoVMh5eRKDA==
X-Received: by 2002:aa7:9806:0:b0:6d0:8b0f:1091 with SMTP id e6-20020aa79806000000b006d08b0f1091mr3281014pfl.30.1704723058786;
        Mon, 08 Jan 2024 06:10:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p5-20020aa79e85000000b006d9ef76732esm6030213pfq.213.2024.01.08.06.10.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:10:55 -0800 (PST)
Message-ID: <659c026f.a70a0220.e4b9a.df81@mx.google.com>
Date: Mon, 08 Jan 2024 06:10:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.299-cip105-289-gad0914f265af
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-filesystems: 7
 runs, 2 regressions (v4.19.299-cip105-289-gad0914f265af)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 14:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14284

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-filesystems: 7 runs, 2=
 regressions (v4.19.299-cip105-289-gad0914f265af)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.299-cip105-289-gad0914f265af/plan/kselfte=
st-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.299-cip105-289-gad0914f265af
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ad0914f265af139fd53d721f0db787b707de20ef =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/659bf8fc2b9e91fe0052a3f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/659bf8fc=
2b9e91fe0052a3fa
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/659bfc2fce02ed241852a3f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig/gcc-10/lab-=
cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig/gcc-10/lab-=
cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/659bfc2f=
ce02ed241852a3f9
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =20


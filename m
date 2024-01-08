Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C16C4707B
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 14:11:05 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web11.7446.1704723060658231073
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 08 Jan 2024 06:11:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=bGbemE32;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.48, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc1fdc19b6so1502493a34.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 08 Jan 2024 06:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704723059; x=1705327859; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h78NGsQY0E/5BRKXRaHLTMYqCIUPW3cfjCvG9rzExtE=;
        b=bGbemE32q+GzyiObEmwq1Ob41dDugc6G/u4INqLlLcZf347RpmBonr2FSgJoVDxc7A
         uG2cEsoxXitlZZr2Ts7JGNdPlExA1KWZ3bfdbvNbIMQmBCjRCjLiPTgTN6NKPWPMOxAl
         KgV/o4lTM2arVRfTgm3maNQzmvS2Sa/IOkwGmpbB9UJzLNDIe/iaBdqMwkHnf9kvXDee
         6PlLcJFCmNJYGnZKYQWPmQylLG5/ogZjJdI4Cdpm9E72It4Z4bTUyfoGp0ora8LR1zgQ
         0of/RUKqLrCsLcwL07P6YeKHsCjAILogscpoKBBHujSvg1kRPwRz6dMO3H2OADNZQ/lY
         W1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723059; x=1705327859;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h78NGsQY0E/5BRKXRaHLTMYqCIUPW3cfjCvG9rzExtE=;
        b=kIL8GD0mecFQMXznLFGFQ6DAvkL8lSlEX1kY1MdGqK9uN9i5FClIJryAb4+MSljKyt
         jiBNPWDuqn9/IVFshcMPmMBF8+2I84tj38USgLl6CgRariyANYE8JeyKY/uvSqQhpjog
         r8V6udyN5t8rqd1+J98WfovhdkYw0kw3Z78IvGh3P4fRUtyN82o17v7XE+Azpu5iaawp
         fggxYz3JeZj/1oeSKmCh6lXOl3seKk3bcE8HNHhlkTzJ5hYSe9FNXB1UEHdGCeYKiXfQ
         lDCBMUCtk7w6rG5VdRxCejJL4/iAQ+xa27mMbEMxPdnnic25xLDUpN6+sTOwIgvjvKj2
         GljQ==
X-Gm-Message-State: AOJu0YyKxU4ycN5UZlGiUoX1QNlAeKvYVKrpUL2/Mm9a5hnoZlzm+HkF
	Q9v6L31IIr/1FGedAEYZkqm4vXJI9E1Q1R8DiQ0wK95AGQ4=
X-Google-Smtp-Source: AGHT+IG5hXQ7xWEUi9RIeCRANL8fEs+Sxv0nnntuwMm8BPlLPlSTe9JumygKu3GKDspUSURB4qzeHg==
X-Received: by 2002:a05:6358:63aa:b0:174:b348:3a96 with SMTP id k42-20020a05635863aa00b00174b3483a96mr4769392rwh.20.1704723059222;
        Mon, 08 Jan 2024 06:10:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s184-20020a635ec1000000b005bdbe9a597fsm6035228pgb.57.2024.01.08.06.10.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:10:56 -0800 (PST)
Message-ID: <659c0270.630a0220.251b6.d5d5@mx.google.com>
Date: Mon, 08 Jan 2024 06:10:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.299-cip105-289-gad0914f265af
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 6 runs,
 2 regressions (v4.19.299-cip105-289-gad0914f265af)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 14:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14285

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 6 runs, 2 regressions (=
v4.19.299-cip105-289-gad0914f265af)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.299-cip105-289-gad0914f265af/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.299-cip105-289-gad0914f265af
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ad0914f265af139fd53d721f0db787b707de20ef

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/659bf9d5e2f69ed43a52a463

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig/gcc-10/lab-=
cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig/gcc-10/lab-=
cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/659bf9d5e2f69ed43a52a4=
64
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/659bfcf700efe5cc8752a3ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/659bfcf700efe5cc8752a4=
00
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =20


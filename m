Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FCDC5475B
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 22:46:55 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web10.9702.1709765208566838682
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Mar 2024 14:46:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qzlX844m;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso182903a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Mar 2024 14:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709765207; x=1710370007; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bs+Dzd995oeBCK9kJ7nwhI400dNpHHCeEC4pcwGBRAs=;
        b=qzlX844msxWZ+apqyAG7mwv7jHvwh8bNqp2Ax3d4E4PuSxYD8PbXXazuXkw8JDhMpb
         s7sUjuafZ0xMMTpa/JJhvp/AtSIgphPRf/txETJl97LpUE+whQ4mgGK9UkKDEo5rU3So
         Cy34Mh52HHDiNQTZ1Ofg/mOIAQDyQfdfEEsHZaUpS6Y642qLlWVkIVHHu0Ahv6H290L0
         H7hR2094KcPlgX4e5jg5UN/DiMNT7R8FrCQPfitbrZZizOKT7GEPIb/t1zfYydl2k9PC
         ZxLxFinQ/Ox0WuGXce9g5zUtjN8GgqrjNkBTc1vHl7I05ZcnEeV1dreOe7QYuGNz58mj
         vW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765207; x=1710370007;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bs+Dzd995oeBCK9kJ7nwhI400dNpHHCeEC4pcwGBRAs=;
        b=vo3mW6N/qiJSd0XpfP+z9M9cvYX1fVvWJ/wa8+yURiY6FtQXt8ILS0nM/jrlA0npdx
         CA7At22OwFd50NwBbWWo2TN3DJoZG0uhB3oNCVCIbC3qoCHcRMqkFgiDpkc8ryUb10Z7
         UaQzzPFJvhY7MBPoxtt5UygFmF71a3+rHAobopvi1Q0ADqwcjcQZdXSbfIBNa3Rnuxzw
         fgUC2RgLSBAIdbuXzHHAHpYNxZe6YKPjdxI3R0b3KAGtTH0JMsFCgAjjAOCHDyoBV+RB
         G8PU78pdPFjfAjN6ZOVnAbIHpytrBnf/zEmwy+DQj1IcrWiTCRuhfJAjL1fHdJjeMY1l
         9aFg==
X-Gm-Message-State: AOJu0Yzblh2TFEhvwfUZXoqsoyl/WfDAXmx23JL0c9PCsadDlfc/mNC7
	ZWvcf6iB4OSjqdaamVoJxudjwpkTZGmh8NQ+XhGoNxn0z7sTvzJ6m2a18MrlWCeiu5iUJtLJWbg
	6TBQ=
X-Google-Smtp-Source: AGHT+IHb6QG3Bvoggw3WPl710rT+KKewMpmWbRmckRX1rHq71omMSGB80ntxxnFPrmmfNZ/OQIQbfg==
X-Received: by 2002:a05:6a21:99aa:b0:1a1:4fce:8eec with SMTP id ve42-20020a056a2199aa00b001a14fce8eecmr6430802pzb.11.1709765206872;
        Wed, 06 Mar 2024 14:46:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b1-20020aa78101000000b006e6350986a8sm4137133pfi.215.2024.03.06.14.46.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:46:46 -0800 (PST)
Message-ID: <65e8f256.a70a0220.61a2d.1c88@mx.google.com>
Date: Wed, 06 Mar 2024 14:46:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.209-cip44-594-gb47da48f3bae7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs,
 1 regressions (v5.10.209-cip44-594-gb47da48f3bae7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 22:46:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15243

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs, 1 regres=
sions (v5.10.209-cip44-594-gb47da48f3bae7)

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
st-lib/

  Test:     kselftest-lib
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


  Details:     https://kernelci.org/test/plan/id/65e8e2434fe046b6b34c4313

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65e8e2434fe046b6=
b34c4314
        failing since 76 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed=
, first fail: v5.10.201-cip41-540-g3640150b3b169) =

 =20


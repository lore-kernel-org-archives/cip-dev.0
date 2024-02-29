Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55063C54E5B
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 09:57:02 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web11.20890.1709200615315086851
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 29 Feb 2024 01:56:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=A47yKCOQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.44, mailfrom: bot@kernelci.org)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c7db34d162so24280539f.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 29 Feb 2024 01:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709200614; x=1709805414; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8ARpkEieQ8JvJolMYh4kzLjR7+QCAqsMjcPMyq+9sV0=;
        b=A47yKCOQ9bRsB6su2wU9vd91LY0ouzBBLxtlc2ZSRTTnP/wd+NSxd3ePsuWDRUAU0x
         JmMakPT+ePhbLkGWnx9Plh7ZMp7+MB8At9ukT4T3iQo1Ht6LYGaa8tVKxxCvd6azATUm
         2uFaoxpaQFjriOCu8OzS68uFuaVESC+cQHGABlvnAY/IjWMjnR7RtcPh+BNOxDV+eS1l
         wU7O4ce8JcabfyYIN+PgMgTxjB+ZBCdDFcOlqOaLXCdFQIdX7DcVaTdiLZqTzBcBDOZb
         EVktv7YDyljikC5tBYVTILLDJD6JYKuLRKg7/E1HwfLRQvxp+LqzkrotkxcIdkgYZPhk
         UPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200614; x=1709805414;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ARpkEieQ8JvJolMYh4kzLjR7+QCAqsMjcPMyq+9sV0=;
        b=uVIPouQ1y+h/3PPcBl3ojH1ib0zZhp5ApWQm6QXqayFrJoW2AjMXSc6opMVW0GmCsw
         O4vk226eYoOBwSK//C05Nf/Vv8yRVdaC6na218tfg6mu/Svca79UP0Nx4iyl8DCNgQPN
         GMT7U/ic9u11zkGbzNqLKB0nxGGYOOfE7mizdGdjhHKFqPVlXhznES5ZIu2sedYz2XID
         v1J6arFBvwBkMGB49qimyu51PFCTv0BZSSgAj3PUXN6qtWGVKKMguPvW+R6QnOGNAFWP
         8DqSmDoe3U0PTPDZdJ5DLbR/vXMCshvcRnQeX/JeefJWJVoWTL3PVUXfKGN4ZP3BwxDf
         HFpQ==
X-Gm-Message-State: AOJu0YyUSgMjeWtVDt9GJcROqOnIDu+wYL/fBiXZ4yPxJKECbNjpMSMp
	kEDvdnEKrQ9VUTvkWUhvUf82xiZhLV9k0r+CCRx4TXbztAdgfJnREKpnNWknp+5a0DTM+qrQul8
	Qa0c=
X-Google-Smtp-Source: AGHT+IHPjgjsTbP/azPuhwQ6z/6y2nrFD9oW8DxIeD+fcwzqdwhdY4hYRjVnSbokrloE9KeAj35hCQ==
X-Received: by 2002:a05:6e02:585:b0:365:22a6:b792 with SMTP id c5-20020a056e02058500b0036522a6b792mr1868224ils.7.1709200613828;
        Thu, 29 Feb 2024 01:56:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s16-20020a056a00179000b006e1464e71f9sm893207pfg.47.2024.02.29.01.56.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:56:52 -0800 (PST)
Message-ID: <65e054e4.050a0220.ee90f.23ee@mx.google.com>
Date: Thu, 29 Feb 2024 01:56:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-56-g55117716ac0fd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 9
 runs, 1 regressions (v5.10.209-cip44-56-g55117716ac0fd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 09:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15107

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 9 runs, 1 r=
egressions (v5.10.209-cip44-56-g55117716ac0fd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-56-g55117716ac0fd/plan/ltp-fcnt=
l-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-56-g55117716ac0fd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      55117716ac0fd541adb5a35e66eb21c45107b040 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65e0460e68ef513ef9637019

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65e0460e68=
ef513ef963701a
        failing since 98 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02=
, first fail: v5.10.200-cip40-188-g33d0b44cd71d) =

 =20


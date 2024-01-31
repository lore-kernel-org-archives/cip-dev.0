Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49D6C47DB3
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 13:21:37 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.13592.1706707290525708227
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Jan 2024 05:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=2J/1H1+K;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d93ddd76adso1530455ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 Jan 2024 05:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706707289; x=1707312089; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dCZrX27dI/qfashcbylY1UeB1nNGwKbKAUlKEwTnqVQ=;
        b=2J/1H1+KPRSDtDHwWc4JSNwVoJCkOhtzcr46vh2yz4x4TWWv6RIAmh501X4H29Swcq
         zy8/Ah7AQ08nxy9XrqzRTjS3lrQcvHBqPUtbvWdJQfZSb6ExI3Qv3YncyPT52iN0PJ01
         tza0NIOW3jRyl0zu0qLoFlGeKhWGGc+coOdNklc72WJnegbDMVvjXPqV+ISQC/xUtuLv
         XO+DuGNNDzfI8GwYRa/gJFtIXieDs+ZF2Igv0hz4vJdpSVLPfprJAyf/opLfYOoEVdhy
         b+TZ9p9jrZA/CYVFuvoW9e/S9AQRXRcmCwsqfGp8ZtT0YpBfJBe6LimEa3gG8eCwshoC
         l6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707289; x=1707312089;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCZrX27dI/qfashcbylY1UeB1nNGwKbKAUlKEwTnqVQ=;
        b=KFZ3tmOI2Yv/B0wUxnmluLAV4LN9UCEb7J4RRH/cg5qF8u90G7aIwjyC03pjEcmYGt
         rH7n3On8JPoFnpO7UQh2jYrusvdAufW8x3Dlk9IcCO1G5ydQOS7hofU+13cXtEfyXl6O
         KTZ6zPH0YWjM7AHPCYJoZC/cufWMWTRfztAFTn/IXz3cHItE2tGhp4x+SI++2rbuEFTr
         ICCFTpoI+pvFpQm7TuKfDpFB1dFh9d2bif/EdXO78HJPwlbLRFeeMzJhIIQSAWSCy/6U
         Un+INDcMlcHubdZ/n3BIbbebX6yHQ2sWeZh4w9k5mwe4ybG8HcN7ily8+h/WDNTchKC/
         f+KQ==
X-Gm-Message-State: AOJu0YzGW61pc/te0FYxeNBNnnZfVI149qilS7S7unyeVcsx9n2FsOt/
	3/rj7Gd8abIQOTh2Wgh8PX+Kj5pq1gMDDpk24VZBKtF5wkCWhVNKEMwD+fGQuAplrFpB+2a92Me
	1
X-Google-Smtp-Source: AGHT+IFohrT7OoG+Eiuc6LqZCiAFZpSRAyn/8aRs/yOCmliqrK8+zoOfvs+j7lRDUgoGZzOwrUocLA==
X-Received: by 2002:a17:902:cec6:b0:1d7:8cae:a5e2 with SMTP id d6-20020a170902cec600b001d78caea5e2mr1601869plg.69.1706707289484;
        Wed, 31 Jan 2024 05:21:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170903229100b001d913992d8csm2874562plh.242.2024.01.31.05.21.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:21:27 -0800 (PST)
Message-ID: <65ba4957.170a0220.d8842.85d7@mx.google.com>
Date: Wed, 31 Jan 2024 05:21:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.72-cip13-32-gf60d2e8cb51c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs,
 1 regressions (v6.1.72-cip13-32-gf60d2e8cb51c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 13:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14567

cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs, 1 regressions (v6.1.72-cip13=
-32-gf60d2e8cb51c)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-32-gf60d2e8cb51c/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-32-gf60d2e8cb51c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f60d2e8cb51c9da65ffcfe73144286c27725ceea

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba3a0fc342d499d900a03b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65ba3a0fc342d499d900a03c
        new failure (last pass: v6.1.72-cip13-30-g79e2886a5da69) =

 =20


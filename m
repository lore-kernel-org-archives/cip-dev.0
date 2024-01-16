Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CCFC4707C
	for <webhook@archiver.kernel.org>; Tue, 16 Jan 2024 04:45:12 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web10.4745.1705380303259807111
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 15 Jan 2024 20:45:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=JUR7G9K+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.41, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5957ede4deaso5584041eaf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 15 Jan 2024 20:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705380302; x=1705985102; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0B+T3yy7S+7X24I1STBYY51yjAxXrP4ucUQwBIGs4uo=;
        b=JUR7G9K+wsageESkoeh/gZgFm46LIS1eGxjW2S58Ko4PuwdCR6zMrw8WVLGioKFwRc
         3nES2Z13hKWn92NQXFL1H4dBxoYk1w0vNxjXx/jOygpTa6/hwymmylsMCEmKE6T1dNuC
         Kc1BU9j0reUd6mQBRpyUMsRmWdZtlcqQJWznWbf3LFgDh/GxvPKtc+xsMJ3nu6HaeQMu
         PubvdQZgm53zVE67HFwKr7Dz1aUJRhHwULlY+bvfnGwPyckXxd/bjDEUn1aUTuhvuQ8J
         SqrEHaaLbk9zBUTNmcg/oSVMw/Ivv3Fk3fsznX0uJ0rawWxXSverbXvtVlYxBKxbEaPN
         fssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705380302; x=1705985102;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0B+T3yy7S+7X24I1STBYY51yjAxXrP4ucUQwBIGs4uo=;
        b=YGqvvCax8Hh+X6D1R4i3aBAj3LQdZbvWnCg8Ir6ZLBjkMEHuBC1hv/17vPJH6ugU7Z
         LdFCtD80xp5xWv05zvtRlvs9xQXzeR9B/7Zxv/dZ0y+pgTLPF2ktScyaqagbGuKnwLus
         Y9k2g2tATOac32XOxbOdtjnyrNdTmRCVJyzN1VzSrj8znfcrCzmOMp7S1I+iuyK5IcIR
         Sv2xyit05KoVo+HpoqIEHfeAjRODL9kS7WnfqeibpfrDQXTil7qYA39sZbN8aCPxTvln
         p/xK26Kw93hz1Tl+Qsy9SfL1wADFZzLQaU5M0XuLSgMf4wMKrr6wQQ4ku9i1OuSTFQsV
         it+A==
X-Gm-Message-State: AOJu0Yyi2jnjU6axQzKyllTGqpnlJ+gZsSO6CPVW2qb3fzbiZtJVbLZ1
	33149pQ0avQwwQSV4MY+I9XrYVHNXoiPFOVD9byH7ntUwZGRTQ==
X-Google-Smtp-Source: AGHT+IEil5sgl1GhEOazmpSxCII2HeU930jvRs4f8LzNxVJJeml3jyOdf0jyCE2d04+yXLI941V2EQ==
X-Received: by 2002:a05:6358:e826:b0:175:c51c:c696 with SMTP id gi38-20020a056358e82600b00175c51cc696mr4081875rwb.36.1705380301665;
        Mon, 15 Jan 2024 20:45:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709028a8400b001d3aa3b8309sm8365021plo.178.2024.01.15.20.45.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 20:45:01 -0800 (PST)
Message-ID: <65a609cd.170a0220.77c85.b055@mx.google.com>
Date: Mon, 15 Jan 2024 20:45:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.304-cip106-27-gf3e967c370d44
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-mm: 6 runs,
 1 regressions (v4.19.304-cip106-27-gf3e967c370d44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jan 2024 04:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14392

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-mm: 6 runs, 1 regressions (v=
4.19.304-cip106-27-gf3e967c370d44)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.304-cip106-27-gf3e967c370d44/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.304-cip106-27-gf3e967c370d44
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f3e967c370d44f37d5b1b2cc02e9898573c4a4ee

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a602e0f5c61d3cca52a4ce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-27-gf3e967c370d44/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-27-gf3e967c370d44/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65a602e0f5c61d3cca52a4cf
        new failure (last pass: v4.19.299-cip105-289-gad0914f265af) =

 =20


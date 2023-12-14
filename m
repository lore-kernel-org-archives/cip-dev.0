Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF83C4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 01:41:54 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.12280.1702518106251192901
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Dec 2023 17:41:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=xnEJFt5w;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.48, mailfrom: bot@kernelci.org)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7b771176f80so121521339f.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Dec 2023 17:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702518105; x=1703122905; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y+AzUX295F4YFir0ADtbaXZx+VhzPPPoPK0kjJvQqF8=;
        b=xnEJFt5wopxwgKkkX5YWwV5yZbtsx/srOCZuZBXXCQdl5m5raX7irdoc4hLh8XdoN+
         5V4mxPw/pNXpyJPsEZ3u8GHxHc4b8Vls8esIrTHJIfU5PGJxOuSxzLX6Sk4QBtA32YSi
         FmY9I+is2n0hldXYlJm/12t7IbT6DOU6hmOc6BTTx4dsFDxrn4O01MbIElydiy6g06tP
         Mp0cSY0iQYfpzVFJ4hCwquGxdacr1vy0ewKg4xCzVNCHZqUC1iViJ4EcTxjLMjev8CRi
         wS1ZlmJN7BxdTVT06OZbqSA8R/zYh67okxgzMEXrXhecOR5IKccXQ2Kvh6Mobx+oWOvJ
         ozZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702518105; x=1703122905;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+AzUX295F4YFir0ADtbaXZx+VhzPPPoPK0kjJvQqF8=;
        b=xQkV4+cjpaKpkNHre4dwnLtj9JM9djL9GpdMaILQ0IzAyh+QN8bloU4UXbvi48bZBQ
         oy33xhusNyJ4eDX3MsgOwWYGBT+HzhrcU0RbEsULIivKHFDdiPfe0Qx67g/TfAlAVxaD
         YcKgqz4kYw0UXcdE8C9c9bXNIaVBfomivivt3/iF9XttsFCoUrdjCBsZvnvc1uRT8XBF
         bCZqlv50PDT3iyYIh8OVsODV4MQda7FyD+e1D9A4i5Z0PtTuU8m1JaS1oVUAwPK+K9oO
         cGmgcPq+e1dW+vDBDS+qA2/EEotqCDXict6z3EOseuDfR30Vq/+f1iqVJH1rvbrVayD9
         vh6A==
X-Gm-Message-State: AOJu0YymYReZMKuXukLWKUC1LiIOMJPAIzTxhDY3+EIejgOyty+z3eUX
	TKJ3ScXTei8EKWQQo8bKx6bWFEs2IG4vudhq5a3Vyg==
X-Google-Smtp-Source: AGHT+IHkYFRBXsHTCBRQW74f9awZsblzVskIh4ai1CSi17qyQLtKFmBDD65jvJoP8De+T5ZlnOj/eA==
X-Received: by 2002:a05:6e02:1a6d:b0:35f:7316:7c9b with SMTP id w13-20020a056e021a6d00b0035f73167c9bmr2301588ilv.129.1702518104921;
        Wed, 13 Dec 2023 17:41:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm11151949plf.79.2023.12.13.17.41.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:41:42 -0800 (PST)
Message-ID: <657a5d56.170a0220.b5304.3cc8@mx.google.com>
Date: Wed, 13 Dec 2023 17:41:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-473-gc43d7b7bbe83a
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 10 runs,
 1 regressions (v5.10.201-cip41-473-gc43d7b7bbe83a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 01:41:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14081

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 10 runs, 1 regressions =
(v5.10.201-cip41-473-gc43d7b7bbe83a)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-473-gc43d7b7bbe83a/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-473-gc43d7b7bbe83a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c43d7b7bbe83ae0f7e001ac115b838d7cd1afe79

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/657a514e660c364445e13480

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/657a514e660c364445e134=
81
        failing since 41 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20


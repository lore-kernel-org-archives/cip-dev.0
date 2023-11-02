Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB72C001B0
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 17:49:20 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.38290.1698947354590131141
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 02 Nov 2023 10:49:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=DV0VzzsF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-565334377d0so866579a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 02 Nov 2023 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698947353; x=1699552153; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pXhZGUMyMu0DUJjTF4LUzV/QtSqmcu0h3W1qUaaD9Qk=;
        b=DV0VzzsF0AbIRQOC2hEd9bxJ59vt8aQCIFNvBhpdy4zKXvIcCAc5zSQS1GbZVHK1RO
         80bxkTV4rU1ryAmXKh6oUjxHjdAvVmFI/ICz0QufXIzqo0vGKekHom3NX9oxHeOMx6qe
         vP6TYmRvBqASBL9QitpnSDwQtFgugw7y3gFcNbDgy0fEsrJZCPE6SZSrOf0m9K9SkKyp
         qPN8FBsAWbqYqqHUMCIpI3ExcjjlqBXoQsEwVf7KD0YVNZKGQUtOKMjrC3ttx94YK1fn
         Kd2QppaU1tEtIcTlpkkhJy8v390XmNdXJ5u7YTLej81x75vv+z/VKqrKOeGCZ+DQgVs9
         1ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947353; x=1699552153;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXhZGUMyMu0DUJjTF4LUzV/QtSqmcu0h3W1qUaaD9Qk=;
        b=sUOw8NWca9IopJxLupFI5MVj6u08IfSpwzb4dKzw+14S1SchRWuyP6GdQQr2eiXbcf
         qXaNaM5Z7fffkYbxYxqYxQ98jvsWASrpTcNxt9NlKWNlFh8+K8utEWZXHh+Dn56eTULR
         m867DhDJqhfyJcl/w6I2RiFvOYcR37jfKWwtTAUkN/N00srZ3Gkc+ZlbMP32wFsIuRVh
         uEyyrmMxJxoU7v4h0QzlTQxIeqH8PFaAzUvx4rAJ8G1YhJDaBSdf47VY4ULb+lnACHC2
         5399MSsbGyprP0MBpQ6PyEIihXVtKyj/TYM92Gd6/7KGIrec62tJTxhDy++eDNd6A+GH
         YikA==
X-Gm-Message-State: AOJu0YwQX/5m3PssubBu7+uAhfTQ2T2Z7ghl51pF+p7Qkr2RlEWIxsUT
	Y/IGuT04fhruwoMyOXGeEIsla1p2+FVTqUQpAjZHrw==
X-Google-Smtp-Source: AGHT+IEKTtm/sxVJfzQlhBf3k0nvEZKo0uaikKsD9Ah/OAJJZDvXLxwtpk4AhjMCvuncl0kOKmcPhA==
X-Received: by 2002:a17:90b:293:b0:27d:1972:136c with SMTP id az19-20020a17090b029300b0027d1972136cmr18156054pjb.38.1698947353358;
        Thu, 02 Nov 2023 10:49:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q22-20020a17090ad39600b0027d06ddc06bsm158121pju.33.2023.11.02.10.49.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:49:12 -0700 (PDT)
Message-ID: <6543e118.170a0220.83e36.0dfa@mx.google.com>
Date: Thu, 02 Nov 2023 10:49:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-915-g96fa7f16cf02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11
 runs, 1 regressions (v5.10.194-cip39-915-g96fa7f16cf02)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 17:49:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13524

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11 runs, 1 =
regressions (v5.10.194-cip39-915-g96fa7f16cf02)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.194-cip39-915-g96fa7f16cf02/plan/ltp-fcnt=
l-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.194-cip39-915-g96fa7f16cf02
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      96fa7f16cf0228e65eeaeaeef1b73f242f4e169e

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


  Details:     https://kernelci.org/test/plan/id/6543ce8f11ef2913d0efcf0a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6543ce8f11=
ef2913d0efcf0b
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =20


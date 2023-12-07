Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB0DC46CA0
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:13:10 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.103805.1701983585542591114
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:13:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=NW9oHWzf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d06d42a58aso12472915ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983584; x=1702588384; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j6v0Ou3tLUoAAtJMh1i/6XLVG8YpYS6fXGvNNRU1Ros=;
        b=NW9oHWzfHwwzH/AJyzeqw2D53uL+6m+1X91zuhnNQkRjA3MFXWAHR4vYFzir+RuNk1
         N8kzgr+lz2giTuDm8I3esRKV6I3ZiGkm+NDk82tOPrpiopGiQosH0y0efcxYgq+9oLKq
         PS6TxsuOpzB5U2wXyFdyCBYZcYN480tNZeGKzxlg7POsrxiVHAx2WBs3cqBoJWn9cpn8
         4/1xYL1MSBhLGymVoZYKWzGDIOLe+xUevcQgS0wJP5GERkkg1wy2QbuklUauwSLeErzE
         KhkST5mOwXrAA7BWPs+MHf9WiWgTmoyUtELITqhxIl8nIzdtVwC1jfd8xqBZ9wXiEQXk
         ExAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983584; x=1702588384;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6v0Ou3tLUoAAtJMh1i/6XLVG8YpYS6fXGvNNRU1Ros=;
        b=bTtWoBfoIMvOGbymV6KVpRBnIkjJcFhIHXN0J0Wc3+V7h6eVCCMTsmANcYN+Ii8Y95
         k6AkNmhl8/0O9NhL9RG6dnZxRxaq6/FbjduiPNnFHq2/FYGd0xo+JTA8PpF4LX/UQPx0
         TPsRZjTV3cjLezPcZLtMiBHPrvdCd5JO3m44VPvoKWJ/x8itrcQrbQwD6bk3yoRDuzEH
         3lYJxC79CaiF46eRMaOJnNfWtQNj+R06MpzmwEvtaxcjVvvrwAtLT0IY5ExOf5knZB6o
         7RuSr8A4Acj0TcwmH+YCx2eHw63lgvE+oFLUcF5B+xwQwCAmxRzXmlpH9M/jzgIwXEPX
         BhtQ==
X-Gm-Message-State: AOJu0YytA7chngCh7RuflxOrc7+dZDEUUaaffZe8d3yuvZj2QqJme6zP
	f93JuHH6GXX6godPzJGA78ucbHspKUzd3sg/awJO7g==
X-Google-Smtp-Source: AGHT+IG7/igLTj40iwwcy1BnLEquFprLcnh2uZQzzJ0N0k2jPvkUHvoxPaT7Tw5vfpzic6F8JQXu+A==
X-Received: by 2002:a17:902:7fc6:b0:1d2:e35e:7488 with SMTP id t6-20020a1709027fc600b001d2e35e7488mr1106978plb.18.1701983584465;
        Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902a70d00b001c726147a46sm254566plq.234.2023.12.07.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:13:03 -0800 (PST)
Message-ID: <6572355f.170a0220.19e19.192f@mx.google.com>
Date: Thu, 07 Dec 2023 13:13:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:13:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13913

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.201-cip4=
1-28-ga386bc478aa6b)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-28-ga386bc478aa6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a386bc478aa6b422e6dd5d92a540987ddfca9397 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657225f9d67a8e37f8e13486

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/657225f9d67a8e=
37f8e13487
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20


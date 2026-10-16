Return-Path: <bot@kernelci.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B94CCA462
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 02:30:51 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13325.1792117843248315692
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2026 19:30:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci.org header.s=google header.b=MumItHyj;
 spf=pass (domain: kernelci.org, ip: 74.125.82.51, mailfrom: bot@kernelci.org)
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15354aa70e8so1713040c88.1
        for <cip-dev@lists.cip-project.org>; Thu, 15 Oct 2026 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792117842; x=1792722642; darn=lists.cip-project.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FUJ0FzLQVLPgACf6SkU4rj5c0uBNiQPYkbSucCcl2nk=;
        b=MumItHyjudw49JFKygmlGVsFBH+ZOazz5LBAHcILDsWH5eZcsxK6sRhXeR08Hs16bi
         osK1MUkg/xeC3xyiz64eKAaWJJLbKsBuyqLfknffVvTFcjT9xmRRcIdW1Nkoi9GCM4sp
         hKyAfmbSE0MNk4EmI1k/Pb7x8EhbByhqPterdId04h7qhthEvIQDKq9I+YP9XGQoa1vf
         eBGVzPdVZmXIhf5jN/bpGSQY6jzsx9c3R4DUfppA5rhn5HzhKsErC+3HdyvG2ua69vDM
         BmVvPuufLrVFUlHlTnpo3h0ZAUwdLB/bfzBQSpQozHFJ5UmMBp6Akc1J5/yicq0M9gW0
         zwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117842; x=1792722642;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUJ0FzLQVLPgACf6SkU4rj5c0uBNiQPYkbSucCcl2nk=;
        b=y9Zi4xRvsW7w1ws9Mw+U91w+8t+dm7hjTnLNvGawE6/LHEDUNMEv+WPj42sD0KGaCq
         iQ/ySXX7gLale6LIJKZIsxUsSeTwX5yUSszygBcAeLdqhEI1w2fNNvAorbiawS1QaJPN
         ij3IYwfWn7R2Da3jqYFzfptjAqC6l8jGLF2HMdCm3uBZXrU6ozdg+Hw1Mf2fxmurwc5l
         JdgL5r+xPa/YUqtoxIEDp0hzzCae4VqCgNUEFD/U4NKOb13eJb7Yzx2770jdPqHzC8q1
         kT701QOeTDMyxGbiNRoGdDR5LuXYsbbOE80m3to4ajB7RyAkYIX9bUeNpLNyIJmRVLiX
         2YlA==
X-Gm-Message-State: AFq9FYK/5rxmyznb42yNyxz4liOyioUDVHmNhXb8ROcLvngiv3Ig+P22
	shc7sq5oW3QVBbEU8159fjoZCU4YEh6igJzE0kXXXutzwfjsEbxVnGH0tNvrIXI7jVI=
X-Gm-Gg: AYBFou1TVdYxGhdDDjtv9oEmRM/XBHMiKKyMHlfYYAY5VqZYjZ9tvu1VjnFlX5xHtxF
	cov5XjVsXhu6CdVGW3Nogf1iLhlbesdt8sl8fOditp39jqwU8AoBw966ZA+IhGhU4uWzbS/jN/0
	CF3VzhrxlZwh9E6wpvcGLP/3N58dF6AzVXXME3LE1Am05YAtsA+hUS7X//pAtRvgM0sHk4rLVnN
	WuTuKRPuXfqJey9b3D1oaUTshLAlCaEabakNX4efx1NMjalI+jo5NXpvn1AwAmthlTgjeqfibqv
	B9+IPEktkn8+nZF44SnZCRCA67/J4DRfyXLIAAxlLxYkdga5IDShbTBLtQ7yRZ/JwOWm+j3kvf7
	jZjxcqjE1I6W8/uHJx4up+qBTGFFgjTq2WBq7hrXykx8WIsUXuzHmLu2ULuupnCIPX1SPRtuk1P
	LE8PlvX1DsUUMAnggv9w/tt7khxGtMZGu8WAadH8vZOIO2kI8vIC7ExFi7Y/KqulA=
X-Received: by 2002:a05:701b:2092:20b0:16d:c848:d36e with SMTP id a92af1059eb24-16dc848d4ecmr27590350c88.13.1792117842089;
        Thu, 15 Oct 2026 19:30:42 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa3ebsm1372554c88.8.2026.10.15.19.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:30:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] cip/linux-5.10.y-cip -
 ef24e6dcf682f112bcdbb5b39cbed7a8cedcfd46
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: cip-dev@lists.cip-project.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 16 Oct 2026 02:30:41 -0000
Message-ID: <179211784065.391248.1738929409881965877@244668f92ec4>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Oct 2026 02:30:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24476



Hello,

Status summary for cip/linux-5.10.y-cip

Dashboard:
https://d.kernelci.org/c/cip/linux-5.10.y-cip/ef24e6dcf682f112bcdbb5b39cbed7a8cedcfd46/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
branch: linux-5.10.y-cip
commit hash: ef24e6dcf682f112bcdbb5b39cbed7a8cedcfd46
origin: maestro
test start time: 2026-10-14 23:46:52.260000+00:00

Builds:	    3 ✅    0 ❌    0 ⚠️
Boots: 	    3 ✅    0 ❌    0 ⚠️
Tests: 	    0 ✅    0 ❌    0 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org


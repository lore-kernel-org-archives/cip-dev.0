Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57AECF649E
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 02:12:16 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.45779.1727662128537263027
 for <cip-dev@lists.cip-project.org>;
 Sun, 29 Sep 2024 19:08:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eY3P0aSv;
 spf=pass (domain: gmail.com, ip: 209.85.215.171, mailfrom: schmitzmic@gmail.com)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso2893433a12.2
        for <cip-dev@lists.cip-project.org>; Sun, 29 Sep 2024 19:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727662128; x=1728266928; darn=lists.cip-project.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aPYjIkgld85zkgMDdL2BMg/mkYUE9000CHOfMB0E7w=;
        b=eY3P0aSvRpqC6bFlq7t79LGFPBqoDtpyBZR2wCy+OdouOZSA0JeNyXVw48bs0/cX+K
         KtF6/g2iVZ/UfnPcLkzsv1gaZ3L8X2W5GvY6Llc9z3orZQAzhVpbLCIiL1UaiM0gbicj
         wEDPZ4iK5w8CoZzO7ZMSZRGxeyiVHF/RkzIlPIVm6r1GaV1gz7IbCFlzSbwkontLw56p
         tvXMinlfYJvoOsLXM+OBJZkhxLwteCLok19qvFtw0pyKvT4FFasuiNE4vt9DN5wWqu4m
         rwulrzv3YeTpTWVwQhkPmQAmBTVEBaejpXYK+r3IJLW7n2utjQKci94OUezXPv8Locvu
         /osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727662128; x=1728266928;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aPYjIkgld85zkgMDdL2BMg/mkYUE9000CHOfMB0E7w=;
        b=N5JTVhIsi4xGEvtbc94/Y+1xXwfjcHKboxp1vR7KwJgnPj1NtXPptk3S1lVRdc2QEk
         J43amGNKLr3bq1FDwLLr9OmqeT5uUsyDxzDCRogoqKkWLHliLfBdok1Vx7fV+A/MAv7D
         kUrdO20pGilZ6gBjppvcwcF8hGhqdrRNAyjatYT4+udD9crYNllYIwnEh1kzgTAmirP6
         EM4q7BR3nq/opPW0NoYgJ8JXUGQGjPKUDQNvtsu9B9/tyVAZREN0uazeY68zbnUTTwe0
         ZGdztVl9zyCBFRSvNpaL86r+M08se8bSrL4XbU9u+p5Dh3aWHoPrEBIoCccfKHMqUWxW
         UIQw==
X-Gm-Message-State: AOJu0Yze4sV7LSexwiTC/geZKJ4OhtSVh0/43/ivUansyzRfOsYwSyjI
	RUJJIVx0Wvox/ytBouGQEwlIkM8I91TsD0DqxfoDCn+7WaRa/u4B
X-Google-Smtp-Source: AGHT+IFGDVNKA4KCPJ0JGFD/MBXwTnDTftMxkwrbB7myOa1Q4Swo//zzlelXGVyj9qlF1nX+0UAq8Q==
X-Received: by 2002:a05:6a20:d81a:b0:1cf:122b:37d1 with SMTP id adf61e73a8af0-1d4fa6ff534mr13207200637.30.1727662127646;
        Sun, 29 Sep 2024 19:08:47 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-238-248-82-fibre.sparkbb.co.nz. [125.238.248.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26538728sm5173877b3a.214.2024.09.29.19.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 19:08:47 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id D3A69360366; Mon, 30 Sep 2024 15:08:42 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: uli@fpond.eu
Cc: cip-dev@lists.cip-project.org,
	linux-m68k@vger.kernel.org,
	geert@linux-m68k.org,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v4 0/2] m68k v4.4 backport fixes (resend)
Date: Mon, 30 Sep 2024 15:08:38 +1300
Message-Id: <20240930020840.15226-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Sep 2024 02:12:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16931

Resend (partial) of my CIP v4.4 backport patches for m68k.

This series only contains patches 4 and 5 of the previous
series (Al Viro's signal handling fixes) - everything else
appears to have been applied in the meantime, or isn't
really a bugfix. These patches need merge conflict fixes
and are not suitable for cherry-picking from v4.19.y.

Tested on 60830 (Atari Falcon)

Cheers,

   Michael
 



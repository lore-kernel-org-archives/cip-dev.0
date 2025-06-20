Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB0C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 04:25:16 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.2751.1750406831769426672
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Jun 2025 01:07:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JbI+n+/n;
 spf=pass (domain: gmail.com, ip: 209.85.216.52, mailfrom: zaq14760@gmail.com)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso968494a91.1
        for <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 01:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750406831; x=1751011631; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izgpPDBzBHrAcs5q52taOSNvQPwl8P5JwuVWlGXOGdw=;
        b=JbI+n+/nbyt1hRo+/1Bjh65MstEDEe4n+wXZDt6adVm7ZxICclW9sj+2LceCiy/j7e
         9NjdwizqE5144SsR3lUJqhm0bFHH2XryXGNEAGsm8x65ilR+thgQ/98fKl2NaKLNo3o/
         Y9WszI2iOyFfQ9M3WaLugv8YyqdusNQsF3YOPeLUv5zLX/F7i2OmVlOWdtYBEi+InIIp
         E6+RmFSejCvEUVqxWlz/k+3kjlzKvgVTSRDohb7BNukZK5dB4LPRpqMnGGRBewtGi23a
         gOyvNHB+n4FxglJFK2z4xjpY/up/zVqQdQ/z7PTmpI9AWgTQH0qBKPaAdxD2G9bChRZQ
         SwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750406831; x=1751011631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izgpPDBzBHrAcs5q52taOSNvQPwl8P5JwuVWlGXOGdw=;
        b=ARgC24EXgCDeSg8IkHGNRe9aSpUMtYQfNxcI7pBxJfVCF1l7gkZT+E1TW6MUKRlpoN
         /+wOPA9+XpxNALQZpSoKr37OH7a52Pt8yz5JE6TkGFfIQOR7kjt9i62qvROAIC4DY8PO
         Ja4OL4BUGXLBfcOcuMatNuLXOeCJukD4JXY7aYtwjsTDIm45Zv0P1BM5czETq5oWWlJB
         jvhBTUIsHj1XjLcwb+0nKMfMPa5axvVhDRg+qdWV6CP4YxFrM2N6UExCLV0uD8/kPYVE
         j8XWFfU0X/xWAlSHmjWQeUOEVLv4bVC+U2QvgjJGgJiGrFAIC6R/9+Bd4937iIKGanUS
         NOfg==
X-Forwarded-Encrypted: i=1; AJvYcCX9NVlw00E10pMOZCurEL/6movOrC9GEiSJCzFsj+pCkmpcLwJk3n11aC9vL+KDy3k+nS4HN2a5@lists.cip-project.org
X-Gm-Message-State: AOJu0YxjNgWFHd0s7afDpPfxraB97nTaIvMgWI1lCVBugNuNQLIL3s8r
	braEEJ8AxnW+XbM75KWzufP1HAXFQq6hRw7ZI9tkfpWFpJMU/PcaCdR0
X-Gm-Gg: ASbGncu2x6tjqSCUj6kX8Gq9Ri7S/5eZUnZL1c12LW1G8RR1ZFswQ8X28/usFQV3Vm6
	lDP5tAWSMNWWDLL4PRUNqUNYA7q/pVQ3XitOkRL2THdszyS8kSCLd+f5HJXDrUHzgE8kYCSBjdb
	/GF96V1ksMhef/OAIXN7LHCbNknvSFQLPfT5C8h9dga+Ibbk5Qy6NIIqtcoVxs8rb22u1D4WJDr
	h10RWiNKkKkDgPb8PDXNRHZHd7485Qiib/q3JMQL//vDm2R3F8tc5LFp9IIN6YaCVWN1MPVSAM3
	w5OC0jy7raCJzqiFo8tsqfo7zSypKNQTZ0Qjq6Ql4yRjMuk+REiyX49bOVjgGphqiItkSlEVBqL
	Qo381Snww7VWownqOrSXOfTqd6mFzL8mVKGr7oRsVEdmtudW6hw==
X-Google-Smtp-Source: AGHT+IGZ28Gk3K6wdn1WwdyWs4HcB6Xru+0lJb7lTiOcl65kF27qYFbjRivbkZVHnbg6zqSnyFYXcA==
X-Received: by 2002:a17:90b:2748:b0:313:d346:f347 with SMTP id 98e67ed59e1d1-3159d911708mr2985529a91.35.1750406830929;
        Fri, 20 Jun 2025 01:07:10 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159df71d49sm1092688a91.5.2025.06.20.01.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 01:07:10 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: krzk@kernel.org
Cc: drm@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	noralf@tronnes.org,
	robh+dt@kernel.org,
	conor@kernel.org,
	zaq14760@gmail.com,
	onlywig@gmail.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH v2 3/3] dt-bindings: display: Add MAYQUEEN PIXPAPER e-ink panel
Date: Fri, 20 Jun 2025 16:06:30 +0800
Message-Id: <20250620080629.743266-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <615522b2-544f-487d-aeb1-5ba069c322cd@kernel.org>
References: <615522b2-544f-487d-aeb1-5ba069c322cd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 04:25:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19163

Dear Krzysztof,

Thank you very much for your review and feedback.
I sincerely apologize for the issue with my emails bouncing.
As a newcomer to using `git send-email`, I was unaware of this problem,
particularly because I did not receive any bounce notifications in my Gmail inbox or spam folder.
This made it difficult for me to identify the issue promptly.

Following your advice, I am migrating my driver development to the latest kernel (e.g., v6.12)
and will use the `get_maintainer.pl` script from that kernel to ensure the correct Cc list.
I am also reviewing my `git send-email` configuration to prevent further email delivery issues.

Could you kindly provide more details about the email bounce issue, such as specific error messages,
problematic recipient addresses, or any other relevant information?
This would help me pinpoint and resolve the issue more effectively.
Additionally, if you have any tips on configuring `git send-email`
or the patch submission process, I would greatly appreciate your guidance.

I apologize again for any inconvenience caused and look forward to your further advice.

Best regards,  
LiangCheng Wang

